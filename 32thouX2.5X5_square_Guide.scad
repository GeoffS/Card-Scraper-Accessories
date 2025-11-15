include <../OpenSCAD_Lib/MakeInclude.scad>
include <../OpenSCAD_Lib/chamferedCylinders.scad>

cardX = 0.032 * 25.4 + 0.2;
cardY = 5 * 25.4 + 1;;

baseX =  30;
baseEndY = 10;
baseY = cardY + 2*baseEndY;
baseZatEnds = 40;
baseZinMiddle = 15;

module itemModule()
{
	difference()
	{
		union()
		{
			doubleY() translate([0, baseY/2-baseX/2, 0]) simpleChamferedCylinder(d=baseX, h=baseZatEnds, cz=2);
			hull() doubleY() translate([0, baseY/2-baseX/2, 0]) simpleChamferedCylinder(d=baseX, h=baseZinMiddle, cz=2);
		}

		// Card slot:
		tcu([-cardX/2, -cardY/2, -1], [cardX, cardY, 100]);
	}
}

module clip(d=0)
{
	//tc([-200, -400-d, -10], 400);
}

if(developmentRender)
{
	display() itemModule();
}
else
{
	itemModule();
}
