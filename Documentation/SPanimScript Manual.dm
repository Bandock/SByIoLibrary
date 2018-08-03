/*

SPanimScript Manual
-------------------
SPanimScript is a simple scripting language that is parsed at runtime when a
proper script file is loaded.  This is done by creating a /SPanimScript object
with a filename as the argument.  You can either load it by using single quotes
or double quotes.  Loading it by single quotes will include the file within
the resource file/cache for distribution.

After a script file is loaded.  You can retrieve animation states by specifying
the name into the GetState procedure.

Using this scripting language is very easy.  Any command that requires a parameter
will not need any special operators.


Commands:
---------
addstage - Creates a new stage for the animation state.  Make sure to call this
command for each stage you design (including the first stage).



*/