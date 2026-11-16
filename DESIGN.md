# reprap-i4 design

What the i4 is for, the rules a change follows, and the work ahead. Each roadmap item is meant to
become a tracked issue.

## Intent

The i3 MK3S is a printer people can build, repair and change from published files. Later printers
moved away from that, toward custom electronics, closed firmware and parts only one supplier sells.
The i4 is the MK3S carried forward the other way: same open lineage, better where it can be, and
no harder to reproduce.

## Principles

1. **Reproducible from this repository.** Every printed part has source here that renders with
   OpenSCAD. An STL or STEP file with no source is a gap on the roadmap, not a finished part.
2. **Parametric.** Values a builder would change (hardware sizes, clearances, mounting patterns)
   are named variables, so a part adapts by editing a number, not by remodelling.
3. **Commodity parts, chosen by requirement.** Each bought part is a requirement (what it must
   do) plus a widely available candidate, with alternates. No part only one supplier sells.
4. **Swappable electronics.** The frame and printed parts don't assume one controller board,
   firmware or display. Mounts follow published hole patterns, and the firmware is open
   (Marlin, Klipper).
5. **Credited lineage.** Upstream and third-party work keeps its author, source and licence.

## Roadmap

### Every part in OpenSCAD

These parts exist upstream only as STL (and, for most, STEP) files. Each needs SCAD source that
reproduces it, checked against the upstream STL, before it can be changed:

- Extruder: `extruder-body`, `extruder-cover`, `extruder-idler`, `extruder-motor-plate`,
  `adapter-printer`, `fan-shroud`, `plug-aligner`
- Filament sensor: `fs-cover`, `fs-lever`
- Y axis: `y-belt-holder`, `y-belt-idler`, `y-belt-tensioner`, `y-motor-holder`, `y-rod-holder`
- Other: `cable-holder`, `LCD-knob`, `psu-cover-DELTA`, `Spool-holder`, `raspberry_cover`,
  `rpi-zero-frame`
- MMU2S variants: `adapter-printer-mmu2s`, `extruder-idler-mmu2s`, `fs-cover-mmu2s`,
  `ir-sensor-cover-mmu2s`, `ir-sensor-holder-mmu2s` (port only if the MMU stays in scope)

The X axis, Z axis, Einsy case and cable clips already have SCAD source from upstream.

### Open, swappable electronics

- Replace the Einsy case (`Einsy-base`, `Einsy-doors`, `Einsy-hinges`) with an electronics
  enclosure parametrised by board outline and mounting holes, with the Einsy as one preset among
  common 32-bit boards.
- Make the LCD mount (`LCD-cover-ORIGINAL-MK3`, `lcd-supports`) take a display by parameters
  rather than one specific module.
- Define the sensor mounts (endstops, bed probe, filament sensor) by requirement, so commodity
  sensors fit without a custom board.
- Document a reference wiring and firmware configuration for one open controller, as the first
  board the i4 is built and tested with.

### Housekeeping

- Clear the OpenSCAD warnings `just check` reports in upstream files (unused `center` arguments,
  ambiguous cylinder parameters, reversed ranges).
- Make `Einsy-doors.scad` and `print-fan-support.scad` reproduce upstream's STLs, then delete the
  STLs. Upstream's `Einsy-doors` STL has 1.4% more volume than the SCAD renders, and its
  `print-fan-support` STL differs in size by 15.5 mm.

## Open questions

- Is the MMU2S in scope?
- Frame: keep the MK3S frame and extrusions as-is, or open it up (build volume, enclosure-first)?
