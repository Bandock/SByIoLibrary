/*

/TextIcon (Text Icon)
---------------------
Inherits from the /icon type

Variables:
	FontObj/font -

	text -

	icon/OTI -


Procedures:
	New(text,FontObj/font,color=rgb(0xFF,0xFF,0xFF),alpha=0xFF)
		Purpose:  To create a working text icon that can be
		specified and manipulated at runtime.  Works in combination
		with a working font object and supports other features.
		That includes being able to control color and transparency
		through the alpha variable.  Used by text objects as standard
		as well as allowing support for creating image-based text
		objects.

		text - Text to specify when it is created.  Text can be
		changed later by utilizing the ChangeText procedure.

		font - Specifies the font object to use for the text icon.
		This affects how ChangeText works along with other procedures
		included with text icons.

		color - Specifies the color of the text for the text icon.
		Can be changed later to enable visual effects or just simply
		change the color of the text with the SetColor procedure.

		alpha - Specifies the transparency of the text for the text
		icon.  Can be changed later to enable visual effects for
		the text with the aid of the SetAlpha procedure.

*/