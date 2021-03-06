/* ====================================================================

  This is a 3D model of a mechanical puzzle. It is released under
  the following license:

  Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported
  https://creativecommons.org/licenses/by-nc-nd/3.0/

  This means the model is licensed for personal, noncommercial use
  only. Anyone may print a copy for their own use, but selling or
  otherwise monetizing the model or print (or any derivatives) is
  prohibited. For details, refer to the summary at the above URL.

  Puzzle design (c) László Molnár
  3D model (c) Aaron Siegel

==================================================================== */

include <puzzlecad.scad>

require_puzzlecad_version("2.1");

$burr_scale = 14.5;
$burr_bevel = 1;
$burr_inset = 0.09;

// Uncomment one of the following lines to render the appropriate component.

*pieces_1();
*pieces_2();

module pieces_1() {

    burr_plate([
        ["xxx{label_text=Sliproad,label_orient=y-x-,label_hoffset=0.5}x|x..x|x..x|x..x", "....|....|....|x..x{connect=mz+y-,clabel=A}", "....|....|....|x...", "....|....|....|x..."],
        ["xxx|x..|x..", "..x|...|x{connect=fz+y-,clabel=A}.."],
        ["xxx{label_text=L. Molnár,label_orient=z+x-,label_hoffset=0.5}x|x.xx|..xx", "....|....|..x{connect=mz+y-,clabel=B}."],
        ["xx|x.|x.", "xx|..|x{connect=fz+y-,clabel=B}."]
    ]);
    
}

module pieces_2() {

    burr_plate([
        ["x..|xxx{connect=mz+y-,clabel=C}", "x..|x..", "x..|x.."],
        ["x{connect=fz-y-,clabel=C}.|xx", "..|.x"],
        ["xxx|xxx", ".x.|..x"],
        ["xx|xx", "x.|x."]
    ]);
    
}
