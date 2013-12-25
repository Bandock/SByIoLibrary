/*

/FontObj (Font Object)
----------------------
Inherits from the /icon type.

Variables:
	cwidth - Character width, used in combination with the
	capabilities of the /TextObj type.

	cheight - Character height, used in combination with the
	capabilities of the /TextObj type.

	hspacing - Horizontal spacing that is used to determine the
	amount of horizontal pixel space between characters.

	vspacing - Vertical spacing that is used to determine the amount
	of vertical pixel space between each line.

	list/textobjs - Used for storing any kind of text object
	to be used with the Update procedure.


Procedures:
	New(fontfile,cwidth,cheight,hspacing,vspacing)
		Purpose:  To setup the settings of the font object.

		fontfile - Used to specify the icon file that acts as a
		fontset.  You may use the included constant that enables
		usage of the default font.

		cwidth - Allows for defining the width of the characters for
		text objects that use the font object with such settings.
		Use 0 to enable using the default width of the character
		(based on the icon file settings).

		cheight - Allows for defining the height of the characters for
		text objects that use the font object with such settings.
		Use 0 to enable using the default height of the character
		(based on the icon file settings).

		hspacing - Allows for defining the hortizontal spacing
		between characters based on the amount of pixels to seperate
		or to merge.

		vspacing - Allows for defining the vertical spacing between
		lines based on the amount of pixels to seperate or to merge.

	SetSize(cwidth,cheight)
		Purpose:  To alter the size of the characters for any future
		changes of text.  Make sure to use the ChangeText procedure
		of the /TextObj type for text objects that depend on the font
		to have any impact.

		cwidth - Used to change the character width of the font
		object.

		cheight - Used to changed the character height of the font
		object.

	SetSpacing(hspacing,vspacing)
		Purpose:  To change the spacing of the characters
		horizontally and vertically.  Make sure to use the ChangeText
		procedure of the /TextObj type for text objects that depend
		on the font to have any impact.

		hspacing - Used to change the horizontal spacing between
		characters based on the amount of pixels to seperate or to
		merge.

		vspacing - Used to change the vertical spacing between each
		line based on the amount of pixels to seperate or to merge.

	Update()
		Purpose:  To commit any changes made to the font object and
		apply them to any text object that uses the changed font
		object.

*/