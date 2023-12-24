use <catchnhole/catchnhole.scad>

$fn = 360;

// inner diameter of clip
inner_diameter = 21.50; //[::non-negative float]

// wall thickness of clip
clip_thickness = 2.5; //[::non-negative float]

// opening angle of clip
angle = 110; //[::non-negative integer] 10

// diameter of pins at the end of the clip
pin_diameter = 3.5;

// clip height
height = 15; //[::non-negative integer]

// thickness of wallblock
block_thickness = 3; //[::non-negative integer]

// size of bolt
bolt_name = "M5"; // [M1.4, M1.6, M1.8, M2, M2.5, M3, M4, M5, M6, M8, M10, M12, M14]

difference()
{
    clip3D(inner_diameter / 2, height, clip_thickness, block_thickness, angle, pin_diameter);
    x_compensation = bolt_head_length(bolt_name, kind = "socket_head");
    translate([ x_compensation, 0, height / 2 ]) rotate([ 0, 90, 0 ])
        bolt(bolt_name, kind = "socket_head", length = block_thickness + clip_thickness, length_clearance = 0.1,
             head_diameter_clearance = 0.2, countersink = 1);
}

module clip3D(inner_radius, height, clip_thickness, block_thickness, angle, pin_diameter)
{
    linear_extrude(height) _clip2D(inner_radius, clip_thickness, block_thickness, angle, pin_diameter);
}

module _clip2D(inner_radius, clip_thickness, block_thickness, angle, pin_diameter)
{
    outer_radius = inner_radius + clip_thickness;
    block_y = outer_radius * 2;
    block_x = block_thickness + outer_radius; // also x-coord of center point of circles
    poly_x = block_x + outer_radius + 0.01;
    poly_y = outer_radius * tan(angle / 2);
    union()
    {
        difference()
        {
            union()
            {
                // wall block
                translate([ 0, -outer_radius, 0 ]) square([ block_x, block_y ]);
                //  add outer circle
                translate([ block_thickness + outer_radius, 0, 0 ]) circle(outer_radius);
            }

            // subtract inner circle
            translate([ block_thickness + outer_radius, 0, 0 ]) circle(inner_radius);

            // subtract polygon to remove opening angle
            polygon([[block_x, 0], [poly_x, poly_y], [poly_x, -poly_y], [block_x, 0]]);
        }
        // add the pins
        r = (outer_radius + inner_radius) / 2;
        pin_radius = pin_diameter / 2;
        pin_x = block_x + r * cos(angle / 2);
        pin_y = r * sin(angle / 2);
        translate([ pin_x, pin_y ]) circle(pin_radius);
        translate([ pin_x, -pin_y ]) circle(pin_radius);
    }
}
