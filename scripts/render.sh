#!/usr/bin/env bash
# Render every tracked .scad file to STL in OUT_DIR, and fail if any part
# does not render. Library files, which only define modules for others to
# include, have no geometry of their own and are listed as skipped.
set -euo pipefail

out_dir="${1:?usage: render.sh OUT_DIR}"

# Files that define modules only; rendering them alone gives an empty object.
libraries=(
    printer-parts/scad/polyholes.scad
)

mkdir -p "$out_dir"
out_dir="$(cd "$out_dir" && pwd)"
cd "$(git rev-parse --show-toplevel)"

failed=0
warnings=0
while IFS= read -r scad; do
    if [[ " ${libraries[*]} " == *" $scad "* ]]; then
        echo "skip  $scad (library)"
        continue
    fi
    # Keep the directory in the name so two parts with one basename don't collide.
    name="${scad%.scad}"
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
done < <(git ls-files '*.scad')

echo "$failed failed, $warnings warnings"
[[ $failed -eq 0 ]]
