/*

V3 Release (Unreleased):
- Text Objects now use the brand new Text Icon type (/TextIcon type)
- /InputObj type now acts as a base type for many forms of input objects.
- Delay Input Objects (/DelayInputObj type)
- Improved Text Input where it now utilizes a hybrid of image objects and icon objects.
- Display Objects (/DisplayObj type)

V2B Release (July 26th, 2012):
- Fix to make it compatible with stable v494 or later. Due to the changes needed, mob.loc is now set to null by default. There might be a better change in the near future to prevent the need for mob.loc alteration.

V2A Release (October 11th, 2011):
- Few changes made to the Command procedure of the /ItemTextObj type. No longer calls the Unselect procedure for keyboard input and instead used by the ClearInputFocus procedure.
- GetSelectedMenuItem procedure has been added to the /MenuObj type. Very handy when one needs to obtain the currently selected item text object of the menu.
- SetInputFocus has been altered a bit to wait for the window to be focused. This is to prevent issues with keyboard only input for particular menu objects.

V2 Release (September 30th, 2011):
- Efficient Item Text Object Highlighting (uses icon states instead of constant redrawing)
- Onscreen Input (/InputObj type)
- Multi-line support for Text Objects
- Menu objects now inherit from the /InputObj type to enable keyboard input upon focus.
- New highlighting options for Item Text Objects that allows for using icons as side cursors next to items.
- Menu spacing mode support for menu objects, which currently allow for vertical and horizontal listing.
- Update procedure was added to the /FontObj type to commit any changes made to the font object to any existing text object that uses it.

V1A Release (February 28th, 2011):
- Items in menu objects will now properly line up on different icon size settings.

V1 Release (February 24th, 2011):
- Initial Release

/*