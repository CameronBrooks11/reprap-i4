// reimplemented simple and pure OpenSCAD version of the Prusa Enclosure foot bracket
// by Cameron Brooks 2026

// Prusa enclosure foot bracket, reconstructed using native solids.
// Dimensions in mm; no mesh imports or traced polygon outlines.
extension = 18;
$fn = 96;

pad_radius = 14.5;
pads = [[-12.75, -15.75], [15.75, 12.75]];

// Original pads are round, with two straight clipped sides.
module pad(i, inset = 0) {
    intersection() {
        translate(pads[i]) circle(r = pad_radius - inset);
        if (i == 0)
            translate([-40, -27.25 + inset])
                square([80, 23 - 2 * inset]);
        else
            translate([4.25 + inset, -40])
                square([23 - 2 * inset, 80]);
    }
}

// A constant-width bridge between the two rounded mounting pads.
module outline() {
    intersection() {
        hull() {
            translate(pads[0]) circle(r = pad_radius);
            translate(pads[1]) circle(r = pad_radius);
        }
        square([54.5, 54.5], center = true);
    }
}

module slot() {
    hull() {
        translate([-6.25, -0.75]) circle(r = 3.8);
        translate([0.75, 6.25]) circle(r = 3.8);
    }
}

module bolt_holes() {
    for (p = pads) translate(p) circle(r = 1.6);
}

module nut_pockets() {
    for (p = pads) translate(p)
        rotate(15) circle(r = 3.55, $fn = 6);
}

module full_section(with_nuts = false) {
    difference() {
        outline();
        slot();
        if (with_nuts) nut_pockets();
        else bolt_holes();
    }
}

// Separate lower feet, before the bridge joins them.
module lower_feet() {
    difference() {
        outline();
        slot();
        bolt_holes();
        rotate(-45) square([90, 4.5], center = true);
    }
}

// Thin perimeter lips around each raised mounting pad.
module rims() {
    for (i = [0:1])
        difference() {
            pad(i);
            // 2 mm lip, with a flat recessed interior.
            offset(delta = -2) pad(i);
        }
}

union() {
    translate([0, 0, -extension])
        linear_extrude(6.02) lower_feet();

    translate([0, 0, 6 - extension])
        linear_extrude(2.62) full_section();

    translate([0, 0, 8.6 - extension])
        linear_extrude(extension + 2.4) full_section(true);

    translate([0, 0, 10.98])
        linear_extrude(2.02) rims();
}
