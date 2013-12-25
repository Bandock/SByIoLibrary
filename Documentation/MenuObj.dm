/*

/MenuObj (Menu Object)
----------------------
Inherits from the /InputObj type. (V2 Release)

Variables:
	FontObj/font - Used for setting up the font object for every
	menu item created by the menu object.

	hspacing - This enables horizontal pixel spacing between
	different items of the menu.

	vspacing - This enables vertical pixel spacing between different
	items of the menu.

	style - Used for setting up the style the menu items will use
	in the menu object.

	color - Used for specifying the unhightlighted color for every
	menu item in the menu object.

	alpha - Used for specifying the transparency for every menu item
	included with the menu object.

	thcolor - Used for specifying the text highlight color for every
	menu item in the menu object.

	ohcolor - Used for specifying the outer highlight color for every
	menu item in the menu object.  Only applies when the OUTLINE style
	bitflag is enabled.

	ihcolor - Used for specifying the inner highlight color for every
	menu item in the menu object.  Only applies when the FILL style
	bitflag is enabled.

	icon/hicon - Used for specifying the side highlighting by icon for
	every menu item in the menu object.  Only applies when the HICON
	style bitflag is enabled.

	keyboardonly - This variable is used to determine if the menu
	object upon focus is usable by mouse/keyboard or just keyboard.

	spacingmode - This allows control of what kind of spacing should
	be used.  Each one handles different variables for control.
	Lookup the spacing mode constants to know which spacing mode
	to use.

	cid - Used to maintain id status when dealing with item text
	object selection.

	list/menulist - Used for storing item text objects into the
	menulist of the menu object.


Procedures:
	New(FontObj/font,vspacing,style,color,alpha,thcolor,ohcolor,ihcolor,hicon,keyboardonly,hspacing,spacingmode)
		Purpose:  To create a menu object that will eventually
		consist of multiple item text objects with the aid of the
		AddItem procedure.  This can be very useful for creating
		a menu consisting of menu items that follow the same settings
		for each one.

		font - Specifies the font object to use for the entire menu
		object.  Every menu item created in such a menu object will
		use that font object.

		vspacing - Specifies the vertical spacing to use for the
		entire menu object.  Every menu item created in such a menu
		object will seperate by that amount of pixels vertically.

		style - Specifies the style to use for the entire menu object.
		Every menu item created in such a menu object will use
		whatever styles are enabled or use the default style.

		color - Specifies the color to use for the entire menu object.
		Every menu item created in such a menu object will use the
		specified color variable as their unhighlighted text color.

		alpha - Specifies the transparency to use for the entire menu
		object.  Every menu item created in such a menu object will
		use that transparency specified.

		thcolor - Specifies the text highlight color for the entire
		menu object.  Every menu item created in such a menu object
		will use that text highlight color when highlighted.

		ohcolor - Specifies the outer highlight color for the entire
		menu object.  Every menu item created in such a menu object
		will use that outer highlight color when highlighted only
		if the OUTLINE style bitflag is enabled.  Otherwise, you
		may set it to null.

		ihcolor - Specifies the inner highlight color for the entire
		menu object.  Every menu item created in such a menu object
		will use that inner highlight color when highlighted only
		if the FILL style bitflag is enabled.  Otherwise, you may set
		it to null.

		hicon - Specifies the side highlight icon for the entire
		menu object.  Every menu item created in such a menu object
		will use that inner highlight color when highlighted only
		if the HICON style bitflag is enabled.  Otherwise, you may set
		it to null.

		keyboardonly - Specifies the keyboardonly variable to
		determine if only the keyboard can be used.  Handy for
		projects that depend on keyboard only (no mouse involved).
		A value of 0 or 1 can be used.

		hspacing - Specifies the horizontal spacing to use for the
		entire menu object.  Every menu item created in such a menu
		object will seperate by that amount of pixels horizontally.

		spacingmode - Specifies the spacing mode to use for the
		entire menu object.  As stated earlier, different modes are
		found in the constants list of this document.

	AddItem(text,command)
		Purpose:  To add new item text objects into the menulist
		provided by the menu object with the specified command.
		Each call will create a new menu item for it.

		text - Specifies the text for the item text object being
		created for the menulist of the menu object.

		command - Specifies the command for the item text object
		being created for the menulist of the menu object.

	SetMenuLoc(x,px,y,py)
		Purpose:  To place the upper starting point of the menu
		object onto the screen.  It will then start setting up
		the screen locations for each item text object in the menu
		list by calling their SetScreenLoc procedures.  Make sure to
		call this procedure before exposing it to any user.
		Otherwise, you may not be able to it see it at all, even when
		you add the list to the screen variable of a client.

		x - Specifies the x coordinate to where the menu object should
		start on the screen.

		px - Specifies the pixel_x offset of the screen to where the
		menu object should start.

		y - Specifies the y coordinate to where the menu object should
		start on the screen.

		py - Specifies the pixel_y offset of the screen to where the
		menu object should start.

	GetMenuList()
		Purpose:  To return the menulist for setting up a reference
		to the menu object's menulist.  It can also be used to add
		the menulist to the client's screen variable.

	GetSelectedMenuItem()
		Purpose:  To return the selected /ItemTextObj type from
		the menu list if selected.  If no menu item is selected, it
		will return null.

*/