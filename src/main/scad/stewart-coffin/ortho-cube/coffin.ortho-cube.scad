include <puzzlecad.scad>

// Uncomment one of the following lines to render that component.

*multi_color_1();
*multi_color_2();
*multi_color_3();
*solid_color_1();
*solid_color_2();
*solid_color_3();

$burr_scale = 14.5;
$burr_inset = 0.07;
$burr_bevel = 1;

// Main color:

module multi_color_1() {
    
    burr_plate([
        ["xxx{connect=fy-z+,clabel=A}"],
        ["xxx{connect=fz+y+,clabel=B}|x{connect=mz+y-,clabel=A}.."],
        ["x{connect=fy-z+,clabel=E}xx{connect=fz+y+,clabel=C}"],
        ["..x{connect=mz+y-,clabel=E}|x{connect=fz+y+,clabel=D}xx"],
        ["x{connect=fy-z+,clabel=G}xx{connect=fz+y+,clabel=F}"],
        ["..x{connect=mz+y-,clabel=G}|x{connect=fz-y+,clabel=H}xx"]
    ]);
    
}

// Corner color:

module multi_color_2() {
    
    burr_plate([
        ["x{connect=mz+y+,clabel=B}"],
        ["x{connect=mz+y+,clabel=D}"]
    ]);
    
}

// Edge color:

module multi_color_3() {
    
    burr_plate([
        ["x{connect=mz+y+,clabel=C}"],
        ["x{connect=mz+y+,clabel=F}"],
        ["x{connect=mz+y+,clabel=H}"]
    ]);
    
}

module solid_color_1() {
    
    burr_plate([
        ["x..|xxx{connect=mz+y+,clabel=A}"], ["..x{connect=fz+y+,clabel=A}|xxx","...|x.."]
    ]);
    
}

module solid_color_2() {
    
    burr_plate([
        ["x..|xxx{connect=mz+y+,clabel=B}"], ["x{connect=fz-y+,clabel=B}..|xxx","...|..x"]
    ]);
    
}

module solid_color_3() {
    
    burr_plate([
        ["xxx{connect=mz+y+,clabel=C}|x.."], ["..x{connect=fz+y+,clabel=C}|xxx"]
    ]);
    
}
