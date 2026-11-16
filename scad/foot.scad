// simple recreation of a tapered foot with a 2020 extrusion dovetail
// based on eyeballing the original Prusa i3 foot design IRL
// should be printed in TPU, TPE, or other flexible filament
// PP or PCL might work but who has time for that

$fn = 32;

// Rounded rectangular cross-section
module profile(w, d, r = 2) {
  offset(r=r)
    square([w - 2 * r, d - 2 * r], center=true);
}

// Connect two profiles
module taper(z1, w1, d1, z2, w2, d2, r = 2) {
  hull() {
    translate([0, 0, z1])
      linear_extrude(0.01)
        profile(w1, d1, r);
    translate([0, 0, z2 - 0.01])
      linear_extrude(0.01)
        profile(w2, d2, r);
  }
}

union() {
  // Tapered foot
  taper(0, 13.4, 13.4, 0.8, 15.4, 15, 1.2);
  taper(0.8, 15.4, 15, 10, 19, 15);

  // 2020 extrusion dovetail
  taper(10, 8, 15, 11, 8, 15);
  taper(11, 8, 15, 12, 10, 15);
  taper(12, 10, 15, 13, 10, 14.46);
  taper(13, 10, 14.46, 14, 6.34, 11, 1.5);
}
