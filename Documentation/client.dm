/*

/client (Overridden)
--------------------
Overridden /client, containing tweaks to this type and additional
features.

Variables:
	InputObj/IOFocus - Used to store focus on any input object.

	cwindow - Mainly used to maintain window compatibility for
	input handling.

	cmacro - Used to switch between the default macro set and the
	input mode macro set.


Procedures:
	New()
		Purpose:  To enable input mode and maintain compatibility
		with user-defined /client/New() procedures.  As usual,
		make sure to call ..() to obtain input mode and proper
		login.

	SetKeyInputMacro(macroname,key,input)
		Purpose:  To setup a key for input mode.  Only called within
		the New procedure provided by the library.  There is no need
		to ever use this procedure unless desired.

		macroname - Just a name for the macro.  Should be unique.

		key - The actual key to specify.

		input - The actual input to specify.

	SetInputFocus(InputObj/IO)
		Purpose:  To specify focus on any living and existing input
		object.  It is normally called by the Click procedure of the
		/InputObj type and can be used explicitly to create nifty
		functions that deal with input objects.  It can also be
		used on any menu object as it now inherits from the
		/InputObj type.

		InputObj/IO - To set the focus for the IOFocus variable.

	ClearInputFocus()
		Purpose:  To clear out the input focus.  This procedure
		restores normal macro functionality based on whatever
		macro set was used before focus.

Verbs:
	KeyInput(c as text)
		Purpose:  To send input messages based on keys pressed.
		Most will output characters depending on mode while others
		are used for special commands.

		c - Just an argument provided for sending the proper input
		message.

*/