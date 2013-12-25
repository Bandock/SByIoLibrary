/*

This demo is provided for a demonstration of each of the features
included with this library.  Refer to the documentation to find out
how any of this works.

V2 Release:
New item text object was added to Menu 2 to demonstrate the Update
procedure of the font object.

A basic input demo object has been included as well as a dynamic
one when you're on the map.  The latter is used for chatting.

Built-in Basic Host Menu Included (for multi-user testing)

Keyboard Input Support for Menu Objects

Few text objects with multi-line support.

Side Highlighting Cursor/Icon support.

Menu objects now support different modes, which are two are currently
in use for this demo.


V3 Release:
Nothing yet.


There are a few comments provided in this demo source.

*/

world
	name = "SByIo Demo"
	maxx = 40
	maxy = 30
	maxz = 1
	view = "20x15"
	fps = 30
	New()
		..()
		var/TextObj/MTO = new("Hello There!",S5,0)
		var/ItemTextObj/TITO1 = new("Clickable Teleporter!",S4,S6,"Teleport 19 25 1",null)
		MTO.SetMapLoc(20,25,1) // Make sure to go northeast about to find this message.
		TITO1.SetMapLoc(20,23,1)  // Just south of the above message.

var
	ptime = 0
	client/host
	FontObj
		Font1 = new(fontmode=FONT_VAR) // This font object uses the default arguments.
		Font2 = new(cwidth=24,cheight=16,hspacing=4) // This font object uses the same font as the previous, but uses a different width, height, 4 pixel horizontal spacing, and 2 pixel vertical spacing.
		Font3 = new(cwidth=24,cheight=24,fontmode=FONT_VAR) // This font object uses the same font as the previous, but increases the width and height along with a 2 pixel horizontal and vertical spacing.
		Font4 = new(cwidth=6,cheight=10,fontmode=FONT_VAR)
	IntroStyle/IS = new()
	Style1/S1 = new()
	Style2/S2 = new()
	Style3/S3 = new()
	Style4/S4 = new()
	Style5/S5 = new()
	Style6/S6 = new()
	Style7/S7 = new()
	Style8/S8 = new()
	Style10/S10 = new()
	HiMenuStyle1/HMS1 = new()

turf
	icon = 'SimpleGrass.dmi'

mob
	icon = 'BasicGuy.dmi'

IntroDisplay
	parent_type = /DisplayObj
	var
		TextObj
			TO1
			TO2
	New()
		var/AnimState/AS1 = new()
		var/AnimStage/AS1_S1 = new()
		var/AnimState/AS2 = new()
		var/AnimStage/AS2_S1 = new()
		AS1_S1.SetAlpha(0xFF)
		AS1_S1.SetTime(20)
		AS1.AddStage(AS1_S1)
		AS2_S1.SetAlpha(0x00)
		AS2_S1.SetTime(10)
		AS2.AddStage(AS2_S1)
		TO1 = new("Feature",IS,0)
		TO1.InsertAnimationState("FadeIn",AS1)
		TO1.InsertAnimationState("FadeOut",AS2)
		TO2 = new("Presentation",IS,0)
		TO2.InsertAnimationState("FadeIn",AS1)
		TO2.InsertAnimationState("FadeOut",AS2)
		TO1.SetScreenLoc(8,0,9,0)
		TO2.SetScreenLoc(6,0,8,4)
	Display(client/C)
		..(C)
		TO1.StartAnimation("FadeIn")
		sleep(10)
		TO2.StartAnimation("FadeIn")
		sleep(25)
		TO1.StartAnimation("FadeOut")
		TO2.StartAnimation("FadeOut")
		sleep(15)
		Clear(C)
		del src

MainMenuDisplay
	parent_type = /DisplayObj
	var
		TextObj
			TO1
			TO2
		MenuObj/Menu
	New()
		var/AnimState/AS1 = new()
		var/AnimStage/AS1_S1 = new()
		var/AnimStage/AS1_S2 = new()
		var/AnimState/AS2 = new()
		var/AnimStage/AS2_S1 = new()
		var/AnimStage/AS2_S2 = new()
		var/ColorObj/C1 = new(0xFF,0xFF,0x00)
		AS1_S1.SetAlpha(0x00)
		AS1_S1.SetTime(5)
		AS1_S1.SetLoop(-1)
		AS1.AddStage(AS1_S1)
		AS1_S2.SetAlpha(0xFF)
		AS1_S2.SetTime(5)
		AS1.AddStage(AS1_S2)
		AS2_S1.SetColor(C1)
		AS2_S1.SetTime(5)
		AS2_S1.SetLoop(-1)
		AS2.AddStage(AS2_S1)
		AS2_S2.SetColor(S2.color)
		AS2_S2.SetTime(5)
		AS2.AddStage(AS2_S2)
		TO1 = new("SByIo",S1,0)
		TO1.InsertAnimationState("FX",AS1)
		// TO1 = new(MMTxt1)
		TO2 = new("Demo!",S2,0)
		TO2.InsertAnimationState("FX",AS2)
		// TO2 = new(MMTxt2)
		// TO1.SetIconState("FX")
		TO1.SetScreenLoc(9,24,13,0)
		// TO2.SetIconState("FX")
		TO2.SetScreenLoc(8,20,12,14)
		Menu = new(S3,HMS1,0,12,'DemoCursor.dmi',0,MVSPACING)
		Menu.AddItem("Host Demo","EnterHostMenu")
		Menu.AddItem("Enter Map","EnterMap")
		Menu.AddItem("Enter Menu 2","EnterMenu2")
		Menu.AddItem("Enter Item Types","EnterItemTypesMenu")
		Menu.AddItem("View Message","ViewMessage")
		Menu.AddItem("New Menu","EnterNewMenu")
		Menu.AddItem("Input Demo","InputDemo")
		Menu.AddItem("View Intro","ViewIntro")
		Menu.AddItem("Exit",".quit")
		Menu.SetMenuLoc(8,24,10,0)
	Display(client/C)
		..(C)
		TO1.StartAnimation("FX")
		TO2.StartAnimation("FX")

HostMenuDisplay
	parent_type = /DisplayObj
	var
		TextObj
			TO1
			TO2
		TextInputObj/Port
		MenuObj/Menu
	New(client/C)
		TO1 = new("Host Demo",S4,0)
		TO2 = new("Port:",S3,mopacity=0)
		Port = new(C,"[world.port]",Font1,"#FFF",0xFF,5,NUM,OUTLINE|FILL,"#C0C0C0","#808080",null)
		TO1.SetScreenLoc(7,0,13,0)
		TO2.SetScreenLoc(7,0,12,2)
		Port.SetScreenLoc(8,20,12,0)
		Menu = new(S3,HMS1,0,12,null,0,MVSPACING)
		Menu.AddItem("Host","Host")
		Menu.AddItem("Return to Main Menu","EnterMainMenu")
		Menu.SetMenuLoc(8,0,6,12)

Menu2Display
	parent_type = /DisplayObj
	var
		TextObj/TO1
		MenuObj/Menu
	New()
		var/HiMenuStyle2/HMS2 = new()
		TO1 = new("Menu Two",S4,0)
		TO1.SetScreenLoc(8,0,12,20)
		Menu = new(S7,HMS2,0,12,null,0,MVSPACING)
		Menu.AddItem("Return to Main Menu","EnterMainMenu")
		Menu.AddItem("Secret Button!","ChangeHSpacing")
		Menu.AddItem("Secret Exit?",".quit")
		Menu.SetMenuLoc(8,24,10,0)

ItemTypesDisplay
	parent_type = /DisplayObj
	var
		TextObj/TO1
		ItemTextObj
			ITO1
			ITO2
			ITO3
			ITO4
			ITO5
			ITO6
	New()
		var/HiMenuStyle3/HMS3 = new()
		var/HiMenuStyle4/HMS4 = new()
		TO1 = new("Fun with Item Types!",S6,0)
		ITO1 = new("Item Type 1",S3,S7,null,null)
		ITO2 = new("Item Type 2",S3,HMS1,null,null)
		ITO3 = new("Item Type 3",S3,HMS3,null,null)
		ITO4 = new("Item Type 4",S3,HMS4,null,null)
		ITO5 = new("Item Type 5",S3,S3,null,'DemoCursor.dmi')
		ITO6 = new("Return to Main Menu",S2,S8,"EnterMainMenu",null)
		TO1.SetScreenLoc(4,16,12,20)
		ITO1.SetScreenLoc(9,24,11,0)
		ITO2.SetScreenLoc(9,24,10,0)
		ITO3.SetScreenLoc(9,24,9,0)
		ITO4.SetScreenLoc(9,24,8,0)
		ITO5.SetScreenLoc(9,24,7,0)
		ITO6.SetScreenLoc(3,0,5,0)

ViewMessageDisplay
	parent_type = /DisplayObj
	var
		TextObj/TO1
		ItemTextObj/ITO
	New()
		var/Style9/S9 = new()
		var/HiMenuStyle5/HMS5 = new()
		TO1 = new({"Message From Bandock:
I see you have found the brand new text object.

That is very nice!"},S3,0)
		ITO = new("Return to Main Menu",S9,HMS5,"EnterMainMenu",null)
		TO1.SetScreenLoc(4,0,12,0)
		ITO.SetScreenLoc(8,0,10,0)

NewMenuDisplay
	parent_type = /DisplayObj
	var
		TextObj/TO1
		MenuObj/Menu
	New()
		TO1 = new("New Menu!",S5,0)
		TO1.SetScreenLoc(7,16,13,0)
		Menu = new(S3,S3,12,0,'DemoCursor.dmi',1,MHSPACING)
		Menu.AddItem("Main Menu","EnterMainMenu")
		Menu.AddItem("Host","EnterHostMenu")
		Menu.AddItem("Quit",".quit")
		Menu.SetMenuLoc(7,16,10,0)

InputDemoDisplay
	parent_type = /DisplayObj
	var
		TextObj
			TO1
			TO2
		TextInputObj/Data
		MenuObj/Menu
	New(client/C)
		TO1 = new("Input Demo",S4,0)
		TO2 = new("Input:",S3,mopacity=0)
		Data = new(C,"Test",Font1,"#FFF",0xFF,25,TEXT,OUTLINE|FILL,"#C0C0C0","#808080",null)
		TO1.SetScreenLoc(7,0,13,0)
		TO2.SetScreenLoc(7,0,12,2)
		Data.SetScreenLoc(8,28,12,0)
		Menu = new(S3,HMS1,0,12,null,0,MVSPACING)
		Menu.AddItem("Get Input Data","GetDataInput")
		Menu.AddItem("Return to Main Menu","EnterMainMenu")
		Menu.SetMenuLoc(8,0,6,12)

client
	var
		am = 0
		DisplayObj/CMenu
		MainMenuDisplay/MainMenu
		HostMenuDisplay/HostMenu
		Menu2Display/Menu2
		ItemTypesDisplay/ItemTypesMenu
		ViewMessageDisplay/ViewMessageScreen
		NewMenuDisplay/NewMenu
		InputDemoDisplay/InputDemo
		list
			DataScreen = new()
			DataScreen2 = new()
	New()
		..()
		if(host == null)
			host = src
		Intro() // View the intro that utilizes alpha effects.
	proc
		Intro()
			if(CMenu != null)
				CMenu.Clear(src)
				del CMenu
				sleep(5)
			var/IntroDisplay/Intro = new()
			Intro.Display(src)
			MainMenu = new()
			SetInputFocus(MainMenu.Menu)
			MainMenu.Display(src)
			CMenu = MainMenu
		ScreenOutput(source,data)
			var/TextObj/Msg = new("[data]",S10,0)
			Msg.layer = MOB_LAYER+1
			Msg.SetScreenLoc(1,16,4,0)
			for(var/mob/M in world)
				if(M.client && M.loc != null)
					if(source == world || source == M.client)
						var/epos = length(M.client.DataScreen)
						for(var/TextObj/DMsg in M.client.DataScreen)
							var/sy = 4
							var/spy = (epos * (DMsg.style.font.cheight + 2))
							while(spy >= 32)
								sy++
								spy -= 32
							DMsg.SetScreenLoc(1,16,sy,spy)
							epos--
						M.client.DataScreen += Msg
						M.client.screen += Msg
						spawn(50)
							M.client.DataScreen -= Msg
							M.client.screen -= Msg

	verb
		EnterHostMenu()
			if(host == src)
				CMenu.Clear(src)
				del CMenu
				HostMenu = new(src)
				HostMenu.Display(src)
				ClearInputFocus()
				CMenu = HostMenu
			else
				alert("You must be the host to use this feature.")
		EnterMenu2()
			ClearInputFocus()
			CMenu.Clear(src)
			del CMenu
			Menu2 = new()
			Menu2.Display(src)
			CMenu = Menu2
		EnterMainMenu()
			ClearInputFocus()
			CMenu.Clear(src)
			del CMenu
			MainMenu = new()
			MainMenu.Display(src)
			SetInputFocus(MainMenu.Menu)
			CMenu = MainMenu
		EnterItemTypesMenu()
			ClearInputFocus()
			CMenu.Clear(src)
			del CMenu
			ItemTypesMenu = new()
			ItemTypesMenu.Display(src)
			CMenu = ItemTypesMenu
		EnterMap()
			ClearInputFocus()
			CMenu.Clear(src)
			del CMenu
			mob.loc = locate(1,1,1)
			ScreenOutput(world,"[mob.name] has entered the map!")
			// ScreenOutput(src,"To chat press the 'c' key.")
		ViewMessage()
			ClearInputFocus()
			CMenu.Clear(src)
			del CMenu
			ViewMessageScreen = new()
			ViewMessageScreen.Display(src)
			CMenu = ViewMessageScreen
		EnterNewMenu()
			ClearInputFocus()
			CMenu.Clear(src)
			del CMenu
			NewMenu = new()
			NewMenu.Display(src)
			SetInputFocus(NewMenu.Menu)
			CMenu = NewMenu
		InputDemo()
			ClearInputFocus()
			CMenu.Clear(src)
			del CMenu
			InputDemo = new(src)
			InputDemo.Display(src)
			CMenu = InputDemo
		ViewIntro()
			ClearInputFocus()
			Intro()
		Teleport(x as num|null,y as num|null,z as num|null)
			mob.loc = locate(x,y,z)
		ChangeHSpacing()
			var/hs = 2
			if(am == 0)
				am = 1
				while(hs < 20)
					hs += 2
					Font3.SetSpacing(hs,2)
					Font3.Update()
					sleep(1)
				while(hs > 2)
					hs -= 2
					Font3.SetSpacing(hs,2)
					Font3.Update()
					sleep(1)
				am = 0
		Host()
			if(HostMenu.Port != null)
				var/port = text2num(HostMenu.Port.GetText())
				if(port != null)
					var/status = world.OpenPort(port)
					if(status)
						alert("Connection Opened!")
						EnterMainMenu()
					else
						alert("Unable to open connection.")
				else
					alert("Unable to open connection.")
		GetDataInput()
			alert(InputDemo.Data.GetText())
		Chat()
			if(IOFocus == null && mob.loc != null)
				var/TextObj/TO = new("Say:",S10,0)
				var/TextInputObj/IO = new(src,null,Font4,"#FF0",0xFF,60,TEXT,0x00,"#C0C0C0","#808080","SendChat")
				TO.SetScreenLoc(2,0,15,18)
				IO.SetScreenLoc(2,28,15,16)
				IO.layer = MOB_LAYER+1
				DataScreen2 += TO
				screen += TO
				screen += IO
				SetInputFocus(IO)
				IO.SetCursor()
				images += IO.idata
		SendChat()
			screen -= DataScreen2
			DataScreen2 = new()
			var/TextInputObj/IO = IOFocus
			var/msg = IO.GetText()
			if(msg != null && msg != "")
				ScreenOutput(world,"[mob.name]: [msg]")
			images -= IO.idata
			ClearInputFocus()
			del IO