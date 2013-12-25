/*

This demo utilizes actual map text capabilities based on new objects
found in v494 or later.

*/

world
	name = "SByIo Demo"
	maxx = 40
	maxy = 30
	maxz = 1
	view = "20x15"

TestScreenDisplay
	parent_type = /DisplayObj
	var
		MapTextObj/MTO
		MapItemTextObj/MITO
	New()
		MTO = new("Maptext Demo","color: #FFFFFF;",100,16)
		MITO = new("Highlight Test","color: #FFFFFF;",83,16,"color: #FF0000;",".quit")
		MTO.SetScreenLoc(10,0,10,0)
		MITO.SetScreenLoc(10,0,5,0)

client
	var
		TestScreenDisplay/TestScreen = new()
	New()
		..()
		TestScreen.Display(src)