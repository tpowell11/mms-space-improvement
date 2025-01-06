
/* [Text Parameters ]*/
//Text for the plate.
Plate_Text = "UN1.2C";
//Size of the font in mm.
Font_Size = 10; //[1:0.1:25]
//Font
Font = "Atkinson Hyperlegible:style=Bold";

/* [Physical Parameters] */
//Height of the raised text.
Text_Height = 2; //[0:0.1:25]
//Thickness of the supporting plate
Plate_Thickness = 2; //[0:0.1:10]
//Hole Diameter
Hole_Diameter = 5; //[0:0.1:10]
//Hole Padding
Hole_Padding = 2; //[0:0.1:10]
//Border
Border = 1; //[0:0.1:10]
//Additional length
Padding = 0; //[0:0.1:100]
/* [Internal Parameters] */
//EPSILON
EPSILON = 0.1;
$fn=50;
textplate(Plate_Text, Text_Height,Font_Size,Font, Plate_Thickness, Border, Hole_Diameter);
module textplate(Text,TextDepth,TextHeight,Font,PlateDepth, RoundCorners, Hole_Diameter){
    tm = textmetrics(Text,size=TextHeight, font = Font);
    translate([-tm.position.x,-tm.position.y,0]){
    linear_extrude(TextDepth)text(Text,size=TextHeight, font = Font);
    }
    plate(RoundCorners, tm.size.x, tm.size.y, PlateDepth,Hole_Diameter,Padding);
    echo(tm);
}
module plate(corners, width, height, thickness, holeDiameter=0, padding=0) {
    color("black")
    difference () {
          // Generate the rounded baseplate
         minkowski() {
             translate([0,0,-thickness/2]){
                cylinder(thickness/2,corners,corners,center=true);
             }
             translate([0,0,-thickness/4]){
                 cube([width+holeDiameter+padding, height, thickness/2]);
             }
        };
        if (holeDiameter > 0) {
            translate([width+holeDiameter-Hole_Padding+padding,height/2,-(thickness/2)]){
                cylinder(thickness+EPSILON,holeDiameter/2,holeDiameter/2,center=true);
            }
        }
    }
};

