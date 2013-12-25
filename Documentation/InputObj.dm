/*

/InputObj (Input Object)
------------------------
Inherits from the /obj type. (V3 Release)

Variables:
	itype - Used to specify the input type of the input object.

	style - Style flag, determines what the overall appearance of
	the input object would look like.

	ocolor - Used to specify the outside color of the input object.

	icolor - Used to specify the inside color of the input object.

	command - Used to specify the command of the input object.
	This is done by pressing enter when the input object has focus.

	length - Used to specify the maximum length of the input object.
	Determines the number of characters an input object can have.

	cpos - Used for determining the cursor's position.

	icon/IBG - Used for storing the input background if it possesses
	one. It is possible to have no background depending on the style
	flags enabled.


Procedures:
	New(text,FontObj/font,color,alpha,length,itype,style,ocolor,icolor,command)
		Purpose:  To create a working input object that can be
		focused on either by clicking or through other ways.  Data
		can be obtained from these objects as well as utilizing
		commands that work with these objects.

		length - Specifies the maximum character length of the
		input object.  This will affect the appearance depending
		on what style flags are used.

		itype - Specfies the input type to use for the input object.
		Input types can be found at the beginning of the document
		to find which one to use.

		style - Specifies the style to use for the input object.
		Style bitflag constants can be found at the beginning of
		the document.

		ocolor - Specifies the outer highlighting color to use for
		the input object.  Only applies when the OUTLINE flag is
		enabled.

		icolor - Specifies the inner highlighting color to use for
		the input object.  Only applies when the FILL flag is
		enabled.

		command - Specifies the command for the input object.  When
		the return/enter key is pressed, it will call the verb
		specified.  It is an optional argument to allow for control.
		Works just like the one found in the /ItemTextObj type.

	Click(location,control,params)
		Purpose:  To set focus on an input object through a mouse
		click if supported.  The arguments of this procedure are
		inherited and are not required to be used.

	ChangeText(text)
		Purpose:  To specify text inside the input object.  Though
		inherited, it has a different way of handling it.  Very
		handy for specifying default text or data when necessary.

		text - Specifies the text inside the input object.

	GetText()
		Purpose:  To return text data from the input object.  Very
		handy for retrieving input and later using it in different
		verbs and other functions.

	SetCursor()
		Purpose:  To properly set the cursor after it's position
		changes.  Necessary for any movement of the cursor.
		Currently, it is used by other procedures and not required.

	AddChar(char)
		Purpose:  To add characters to the input object.  This is
		normally handled by the ChangeText procedure and the
		KeyInput client verb unless one needs this particular
		procedure.

		char - Character to add to the input object.

	DeleteChar(cpflag)
		Purpose:  To delete characters from the input object.  This
		is normally handled by the KeyInput client verb unless
		one needs this particular procedure.

		cpflag - Cursor position flag that determines if the
		character is deleted on the same position as the cursor or
		simply delete the previous character.

	CursorLeft()
		Purpose:  To move the cursor to the left.  Handled by
		the KeyInput client verb normally; it is not required unless
		needed.

	CursorRight()
		Purpose:  To move the cursor to the right.  Handled by
		the KeyInput client verb normally; it is not required unless
		needed.

	Command()
		Purpose:  To run the command specified in the command
		variable upon pressing enter.

*/