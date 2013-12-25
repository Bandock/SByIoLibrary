/*

/ItemTextObj (Item Text Object)
-------------------------------
Inherits from the /TextObj type.

Variables:
	style - Style flag, determines what the highlighting looks like
	when the mouse cursor is placed on the item.  Default style just
	enables text highlighting.  Lookup the style flag constants
	found at the beginning of the document.  Mulitple style types can
	be ORed to create nice items.

	thcolor - Color the text will become when highlighted.  It is
	possible to change the colors with the use of the
	SetHighlightColor procedure.

	ohcolor - Color the outer highlighting will become when
	highlighted.  Only works when the OUTLINE style flag is enabled.

	ihcolor - Color the inner highlighting will become when
	highlighted.  Only works when the FILL style flag is enabled.

	ccolor - This is based on whatever you have your mouse cursor
	on the item or not.

	command - Allows using client or mob verbs to enable clicking
	functionality of the /ItemTextObj type.  You can also use
	built-in commands like .quit for quitting the application and
	more.  There are some cases it will have verb arguments included
	with them.

	icon/hicon - Side highlighting icon that will appear when highlighted.
	Only works when the HICON style flag is enabled.

	id - Used to identify item text objects within a menu object.
	This allows keyboard input to function on a menu object.

	MenuObj/MO - Used to point to which menu object it resides in.

	icon/HBG - Used to store the background when it is highlighted
	depending on styles enabled.


Procedures:
	New(text,FontObj/font,color,alpha,style,thcolor,ohcolor,ihcolor,command,hicon)
		Purpose:  To create a working item text object for the
		purpose of creating clickable text objects.  Arguments are
		almost the same as the parent with the exception of the
		mopacity being replaced by the style argument. If the style
		is set to 0 (default), it will run the parent procedure.

		style - Specifies the style to use for the item text object.
		As stated for the style variable included, lookup the
		style bitflag constants at the beginning of the document.

		thcolor - Specifies the text highlight color.  Text will
		change to that color when highlighted (by placing the mouse
		cursor over it).

		ohcolor - Specifies the outer highlight color.  As stated
		earlier in the variables section, it will only function when
		the OUTLINE style flag is enabled.  Otherwise, set it to null
		if you want.

		ihcolor - Specifies the inner highlight color.  As stated
		earlier in the variables section, it will only function when
		the FILL style flag is enabled.  Otherwise, set it to null
		if you want.

		command - Specifies the command for the item text object.
		When clicked on, it will run that command or verb.  It
		is possible to include verb arguments just by including it
		inside the command string.  Text type will need backslash
		'\' (must be included as part of the string) and a quotation
		mark '"' to properly read text in multi argument verbs.
		Example:  "TestVerb \\\"Here's your text\\\" 123"

		hicon - Specifies the side highlight icon.  As stated earlier
		in the variables section, it will only function when the HICON
		style flag is enabled.  Otherwise, set it to null if you want.

	MouseEntered()
		Purpose:  To make a call to the Select procedure by mouse
		when the mouse enters the item text object.  If the item text
		object is stored within a menu object, it will determine if
		it is selectable by mouse through the keyboardonly variable.

	MouseExited()
		Purpose:  To make a call to the Unselect procedure by mouse
		when the mouse leaves the item text object.  If the item text
		object is stored within a menu object, it will determine if
		it is unselectable by mouse through the keyboardonly variable.

	Click()
		Purpose:  To make a call to the Command procedure by mouse
		clicking the item text object.  If the item text object is
		stored within a menu object, it will determine if it is
		clickable by mouse through the keyboardonly variable.

	ChangeText(text)
		Purpose:  Works almost like the /TextObj version (the parent)
		since it can make a call to the parent procedure if the style
		is set to '0'.  If another style is specified or/and it is
		highlighted, it will change text while in that state.

	SetColor(color)
		Purpose:  Works almost like the /TextObj version (the parent)
		with the exception if it is highlighted, it will just change
		the color variable and the actual color.

	SetHighlightColor(thcolor,ohcolor,ihcolor)
		Purpose:  Enables changing the color of text highlighting.
		Currently, it only affects the text and nothing else.  It
		may undergo an upgrade in the near future to enable changing
		other forms of highlighting.  If it is already highlighted,
		the change will be noticed.  Otherwise, it will just change
		the variable.

		thcolor - Text highlight color to change to for the
		item text object.

		ohcolor - Outer highlight color to change to for the
		item text object.  Only applies when the OUTLINE style flag
		is enabled.

		ihcolor - Inner highlight color to change to for the
		item text object.  Only applies when the FILL style flag is
		enabled.

	Select()
		Purpose:  To enable highlighting either by the mouse cursor
		or keyboard.  It will change the appearance of the item text
		object temporarily based on the style flags set.  Very handy
		if you need to explicitly select an item text object from
		the menu.

	Unselect()
		Purpose:  To disable highlighting and revert back to the
		original text color after the mouse cursor leaves the item
		text object.  Very handy if you need to explicitly unselect
		an item text object from the menu.

	Command()
		Purpose:  To run the command based on the 'command' variable
		specified.  As stated earlier in the variable section, it
		can run built-in commands or verbs provided for players.

*/