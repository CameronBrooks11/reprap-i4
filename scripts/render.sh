#!/usr/bin/env bash
# Render every tracked .scad part to STL in OUT_DIR, and fail if any part
# does not render. Files in scad/lib/ define modules for parts to `use`, so
# they are listed as skipped; the parts that use them render them.
set -euo pipefail

out_dir="${1:?usage: render.sh OUT_DIR}"

mkdir -p "$out_dir"
out_dir="$(cd "$out_dir" && pwd)"
cd "$(git rev-parse --show-toplevel)"

failed=0
warnings=0
while IFS= read -r scad; do
    if [[ $scad == scad/lib/* ]]; then
        echo "skip  $scad (library)"
        continue
    fi
    # Keep the subfolder in the name so two parts with one basename don't collide.
    name="${scad#scad/}"
    name="${name%.scad}"
    name="${name//\//__}"
    stl="$out_dir/$name.stl"
    log="$out_dir/$name.log"
    if openscad -o "$stl" "$scad" >"$log" 2>&1; then
        n=$(grep -c WARNING "$log" || true)
        warnings=$((warnings + n))
        if [[ $n -gt 0 ]]; then
            echo "ok    $scad ($n warnings)"
        else
            echo "ok    $scad"
        fi
    else
        failed=$((failed + 1))
        echo "FAIL  $scad"
        sed 's/^/      /' "$log"
    fi
done < <(git ls-files 'scad/*.scad')

echo "$failed failed, $warnings warnings"
[[ $failed -eq 0 ]]
