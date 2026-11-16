# AGENTS.md

Instructions for AI coding agents working in this repository.

## Project

reprap-i4 carries the Prusa i3 MK3S printer design forward as open, reproducible hardware: printed
parts in OpenSCAD, built around commodity parts and swappable electronics. It starts from Prusa
Research's MK3S printed parts and their history. [DESIGN.md](DESIGN.md) holds the principles and the
roadmap; read it before changing a part.

## Stack

- **OpenSCAD**: the source of every part. CI renders with the 2021.01 release, so a part must not
  depend on features only in development snapshots.
- **just**: task runner.
- **pre-commit**: gitleaks and whitespace hooks.

## Layout

```
scad/                 # every part's source; each file renders on its own
scad/enclosure/       # enclosure parts
scad/hotend/          # hotend mockups, not printed
scad/lib/             # modules the parts `use`; not rendered on their own
reference/stl/        # upstream STLs with no matching SCAD yet
reference/step/       # upstream's STEP files
reference/frame/      # upstream's frame DXFs and extrusion spec
scripts/render.sh     # renders every part, used by just render and just check
```

## Commands

```sh
just render   # every part to build/stl/
just check    # every part renders without error (CI-equivalent)
just lint     # pre-commit over every file
just test     # skipped: there are no geometry tests yet
```

## Conventions

- A new part is a `.scad` file under `scad/` that renders on its own. A file that only defines
  modules for parts to `use` goes in `scad/lib/`, which `just check` skips.
- Dimensions in millimetres. Put the values a builder would change (sizes, clearances, hardware)
  as named variables at the top of the file.
- Build from OpenSCAD solids. An imported STL is a reference to compare against, not geometry.
- Don't commit an STL that `just render` reproduces. Once a part's SCAD reproduces its upstream
  STL, delete the STL.
- Keep upstream's history and file names intelligible: a change to an upstream part is a commit
  on that file, not a copy under a new name.
- Credit every part not written here in README.md, with its author, source link and licence.

## Constraints

- Prusa Research's names ("Prusa", "Original Prusa") describe where the design came from; they
  are never the name of this project or a part.
- Choose parts by requirement: state what a part must do and give a widely available candidate.
- Do not add AI attribution to commits or PR descriptions: no co-author trailers, session links,
  or "generated with" footers.
- Do not let a check report success when it could not run. A check that does not apply may pass,
  but must name itself as skipped.
