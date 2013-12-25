/*

/TextObj (Text Object)
----------------------
Inherits from the /obj type.

Variables:
	alpha - Alpha transparency to determine the amount of
	transparency for the entire text object.

	color - The actual text color.  Can be changed with the help
	of the SetColor procedure of the /TextObj type.

	FontObj/font - The actual font object derived from the /FontObj
	type.  Currently set upon creation of text objects to aid in
	creating the characters.

	icon/TOI - The actual text object icon derived from the /icon
	type.  Upon text object creation, this object will be scaled to
	enable enough space to store the characters based on different
	settings, length of the text, and the font object provided.

	text - Built-in variable customized to accommodate the
	capabilities of the text object.


Procedures:
	New(text,FontObj/font,color,alpha,mopacity)
		Purpose:  To create a working text object that can be
		specified and manipulated at runtime.  Works in combination
		with a working font object and supports other features.
		That includes being able to control color and transparency
		through the alpha variable.  When you create a text object,
		you may either use it locally or globally.  You can even
		make it where players have their own text objects.

		text - Text to specify when it is created.  Text can be
		changed later by utilizing the ChangeText procedure.

		font - Specifies the font object to use for the text object.
		This affects how ChangeText works along with other procedures
		included with text objects.

		color - Specifies the color of the text for the text object.
		Can be changed later to enable visual effects or just simply
		change the color of the text with the SetColor procedure.

		alpha - Specifies the transparency of the text for the text
		object.  Can be changed later to enable visual effects for
		the text with the aid of the SetAlpha procedure.

		mopacity - Specifies the mouse_opacity of the text object.
		To learn more about this, look up mouse_opacity in the DM
		Reference.  It will have the information needed for this
		argument.

	ChangeText(text)
		Purpose:  To actually change text of the object, which is
		very useful for many things.  You can even use numbers if you
		embed them properly.  This procedure is also called by
		the Update procedure from font objects to make any changes
		in appearance.

		text - Text to change to for the text object.  You can
		use embedded expressions to allow for numbers and anything
		else supported.  The value of 'null' will use the same text
		in order to commit any changes made to the font object.  You
		can just make a call to the Update procedure of the font
		object to commit changes to any text object using that font
		object.

	SetColor(color)
		Purpose:  To change the color of the text object.  Very useful
		for transitioning from one color to another as well as just
		simply changing the color of text for another purpose.

		color - Color to change to for the text object.

	SetAlpha(alpha)
		Purpose:  To change the transparency of the text object.
		Very useful for fading effects and anything you could think
		of.

		alpha - Alpha transparency to change to for the text object.

	SetMapLoc(x,y,z)
		Purpose:  To place the text object on the map.  Can be useful
		for creating on-map text.  Perhaps a sport or anything of that
		sort.

		x - Specifies the x coordinate to where it should be placed
		on the map.

		y - Specifies the y coordinate to where it should be placed
		on the map.

		z - Specifies the z coordinate to where it should be placed
		on the map.

	SetScreenLoc(x,px,y,py)
		Purpose:  To specify where the text object should be located
		on the client screen.  After specifying the screen location,
		you must add it to the client's screen list or at least a
		useful list that can later be added to the client's screen
		list for it to be shown properly.

		x - Specifies the x coordinate to where it should be placed
		on the screen.

		px - Specifies the pixel_x offset of the screen to where it
		should be placed.

		y - Specifies the y coordinate to where it should be placed
		on the screen.

		py - Specifies the pixel_y offset of the screen to where it
		should be placed.

*/