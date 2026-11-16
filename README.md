# reprap-i4

An open, parametric continuation of the i3 MK3S 3D printer: the MK3S design carried forward as an
open, reproducible RepRap, rather than toward closed, proprietary hardware. [DESIGN.md](DESIGN.md)
says where it is going.

It starts from Prusa Research's MK3S printed parts,
[Original-Prusa-i3](https://github.com/prusa3d/Original-Prusa-i3), with all of that repository's
history up to its latest commit,
[`529e5ad`](https://github.com/prusa3d/Original-Prusa-i3/commit/529e5ad6892ce3b25015b7cca7f0481b8335a76c)
(2022-11-14). I'm not affiliated with Prusa Research. "Original Prusa" and "Prusa" are their
trademarks, used here only to say where this design comes from.

## Build

Needs [OpenSCAD](https://openscad.org) and [just](https://github.com/casey/just).

```sh
just render   # every part to build/stl/
just check    # every part renders without error (what CI runs)
```

## Layout

| Path                     | What                                                                        |
| ------------------------ | --------------------------------------------------------------------------- |
| `printer-parts/scad/`    | OpenSCAD source of the printed parts                                        |
| `printer-parts/stl/`     | upstream's STLs, including parts that have no SCAD source yet               |
| `printer-parts/step/`    | upstream's STEP files for the parts not in SCAD                             |
| `enclosure-parts/`       | parts for the enclosure                                                     |
| `Frame/`                 | upstream's frame drawings (DXF) and extrusion spec (PDF)                    |

## What differs from the MK3S

- **Folders.** `Printed-Parts/SCAD` and `Printed-Parts/STL` are `printer-parts/scad` and
  `printer-parts/stl`, with Unix line endings.
- **X ends.** Tarek Loubani's parametric X-end flange,
  [upstream PR #3](https://github.com/prusa3d/Original-Prusa-i3/pull/3) (2016, still open there),
  merged by hand, with the lead-screw hole at 13.2 mm.
- **Frame foot.** `printer-parts/scad/foot.scad`, mine: a tapered foot with a 2020-extrusion
  dovetail, modelled on the MK3S foot. Print it in TPU or another flexible filament.
- **Enclosure foot.** `enclosure-parts/scad/feet-bracket.scad`, mine: the enclosure's foot bracket
  rebuilt from OpenSCAD solids, with an `extension` parameter (18 mm by default) that makes it taller
  so the front and rear can be levelled using the original bolts.
  - It reproduces Prusa Research's `feet_bracket-R1` from
    [Original-Prusa-Enclosure](https://github.com/prusa3d/Original-Prusa-Enclosure) (GPL-3.0), also
    on Printables as
    [Enclosure printable parts](https://www.printables.com/model/251931-enclosure-printable-parts).
  - `enclosure-parts/stl/feet-bracket-original.stl` is that STL, unchanged, for comparison.
- **Hotend mockups** in `printer-parts/scad/hotend/`, for designing parts round an E3D V6:
  - `hotend.scad`: thehans's
    [E3D V6 Heatsink mockup for OpenSCAD](https://www.thingiverse.com/thing:2420969), Creative
    Commons Attribution.
  - `E3DV6.scad`: a fuller assembly (heatsink, heater block and sock, nozzle, fan). Its author isn't
    recorded. It uses E3D's [E3D-v6 Fan Duct](https://www.thingiverse.com/thing:340312) by
    joshuarowley42, GNU GPL, as `V6.6_Duct.stl`.

## Licence

Upstream's `LICENSE` is the GNU GPL v2, while its SCAD files' headers say GNU GPL v3; both are kept
as upstream has them. My own parts (the frame foot and the enclosure foot) are GPL-3.0. The
hotend mockups carry their own authors' licences.
