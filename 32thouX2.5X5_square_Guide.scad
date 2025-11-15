include <../OpenSCAD_Lib/MakeInclude.scad>
include <../OpenSCAD_Lib/chamferedCylinders.scad>

cardX = 0.032 * 25.4 + 0.2;
cardY = 5 * 25.4 + 1;;

baseX =  30;
baseEndY = baseX;
baseY = cardY + baseEndY;
baseZatEnds = 45;
baseZinMiddle = 15;

cz = 2;

module itemModule()
{
	difference()
	{
		union()
		{
			doubleY() translate([0, baseY/2-baseX/2, 0]) simpleChamferedCylinder(d=baseX, h=baseZatEnds, cz=cz);
			hull() doubleY() translate([0, baseY/2-baseX/2, 0]) simpleChamferedCylinder(d=baseX, h=baseZinMiddle, cz=cz);
		}

		// Card slot:
		tcu([-cardX/2, -cardY/2, -1], [cardX, cardY, 100]);

		// Chamfer slot in middle:
		ctrY = baseY - 2*baseEndY;
		translate([0,0,baseZinMiddle+2-cardX/2-1]) rotate([-90,0,0]) tcy([0,0,-ctrY/2], d=4, h=ctrY, $fn=4);

		// Chamfer slot in the ends:
		// translate([0,0,baseZatEnds+2-cardX/2-1]) rotate([-90,0,0]) tcy([0,0,-cardY/2], d=4, h=cardY, $fn=4);
		hull() doubleY() translate([0, baseY/2-baseX/2, baseZatEnds-cardX/2-cz]) cylinder(d2=6, d1=0, h=3);
	}
}

module clip(d=0)
{
	// tcu([-200, -400+d, -10], 400);
	// tuc([-200, 20-d, -10], 400);

	// tcu([-200, cardY/2-1-d, -10], 400);

	// tcu([0, -200, -10], 400);
}

if(developmentRender)
{
	display() itemModule();
	displayGhost() cardGhost();
}
else
{
	itemModule();
}

module cardGhost()
{
	x = 0.032 * 25.4;
	y = 5 * 25.4;
	z = 2.5 * 25.4;
	tcu([-x/2, -y/2, 0], [x, y, z]);
}