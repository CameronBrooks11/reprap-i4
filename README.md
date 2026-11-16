# Original Prusa i3 MK3S: my working copy

This is a copy of Prusa Research's
[Original-Prusa-i3](https://github.com/prusa3d/Original-Prusa-i3) repository, the SCAD files and STLs of
the MK3S printed parts, with my own changes on top. I'm not affiliated with Prusa Research. "Original
Prusa" and "Prusa" are their trademarks, used here only to say what this is. For the real thing, use
their repository.

It holds all of upstream's history up to its latest commit,
[`529e5ad`](https://github.com/prusa3d/Original-Prusa-i3/commit/529e5ad6892ce3b25015b7cca7f0481b8335a76c)
(2022-11-14).

## What differs from upstream

- **Folders.** `Printed-Parts/SCAD` and `Printed-Parts/STL` are `printer-parts/scad` and
  `printer-parts/stl`, with Unix line endings; the files are otherwise unchanged.
- **X ends.** Tarek Loubani's parametric X-end flange,
  [upstream PR #3](https://github.com/prusa3d/Original-Prusa-i3/pull/3) (2016, still open there),
  merged by hand, with the lead-screw hole at 13.2 mm.
- **Enclosure feet.** `enclosure-parts/scad/feet-bracket.scad` makes the enclosure foot taller (18 mm in
  `stl/feet-bracket-ext18mm.stl`) so the front and rear can be levelled, using the original bolts.
  - The script is signed "CJH, 31 March 2023"; I haven't found where it was published or its licence.
  - The foot it extends is Prusa Research's `feet_bracket-R1.stl` from
    [Original-Prusa-Enclosure](https://github.com/prusa3d/Original-Prusa-Enclosure) (GPL-3.0).
- **Hotend mockups** in `printer-parts/scad/hotend/`, for designing parts round an E3D V6:
  - `hotend.scad`: thehans's
    [E3D V6 Heatsink mockup for OpenSCAD](https://www.thingiverse.com/thing:2420969), Creative Commons
    Attribution.
  - `E3DV6.scad`: a fuller assembly (heatsink, heater block and sock, nozzle, fan). Its author isn't
    recorded. It uses E3D's
    [E3D-v6 Fan Duct](https://www.thingiverse.com/thing:340312) by joshuarowley42, GNU GPL, as
    `V6.6_Duct.stl`.

## Licence

Upstream's `LICENSE` is the GNU GPL v2, while its SCAD files' headers say GNU GPL v3; both are kept as
upstream has them. The additions above carry their own authors' licences.

## Upstream's links

 * Prusa Research website : http://prusa3d.com
 * Product page: https://shop.prusa3d.com/en/3d-printers/180-original-prusa-i3-mk3-kit.html
 * Build manual: http://manual.prusa3d.com/c/Original_Prusa_i3_MK3_kit_assembly
 * Firmware : https://github.com/prusa3d/Prusa-Firmware
 * MK52 heatbed : https://github.com/prusa3d/Heatbed_MK52_magnetic
 * MK3 Power panic : https://github.com/prusa3d/MK3_Power_Panic
 * MK3S IR senzor : https://github.com/prusa3d/MKxS-IR-sensor
