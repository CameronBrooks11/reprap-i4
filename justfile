# reprap-i4 task runner

set dotenv-load := false

# Show available recipes
default:
    @just --list

# Check the tools the recipes need are installed
setup:
    openscad --version
    pre-commit --version

# Render every part to build/stl for slicing or inspection
render:
    scripts/render.sh build/stl

# Every part renders without error (CI-equivalent)
check:
    #!/usr/bin/env bash
    set -euo pipefail
    out="$(mktemp -d)"
    trap 'rm -rf "$out"' EXIT
    scripts/render.sh "$out"

# Whitespace, YAML and secret checks over every file
lint:
    pre-commit run --all-files

# No automated tests: `just check` renders every part
test:
    @echo "skipped: geometry has no tests yet; just check renders every part"

# Remove rendered output
clean:
    rm -rf build
