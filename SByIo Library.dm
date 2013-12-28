/*
    SByIo Library
    Copyright (C) 2011-2014 Joshua Moss

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2.1 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public
    License along with this library; if not, write to the Free Software
    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA

    Joshua Moss
    bandock666@gmail.com
*/

var
	const
		SBYIO_DEFAULTFONT = 'HCANSIFont.dmi' // Use this constant if you want to use the default fontset.

		TEXT_LEFT = 0x00
		TEXT_CENTER  = 0x01
		TEXT_RIGHT = 0x02

		FONT_FIXED = 0x00
		FONT_VAR = 0x01

		OUTLINE = 0x01
		FILL = 0x02

		TEXT = 0x00
		NUM = 0x01

		MVSPACING = 0x00
		MHSPACING = 0x01
		// MVHSPACING = 0x02
		// MHVSPACING = 0x03

		DEFINPUT = 0x00
		IMODE1 = 0x01

ColorObj
	var
		red = 0xFF
		green = 0xFF
		blue = 0xFF
	New(red=0xFF,green=0xFF,blue=0xFF)
		SetColor(red,green,blue)
	proc
		SetColor(red,green,blue)
			src.red = red
			src.green = green
			src.blue = blue
		GetColor()
			return rgb(red,green,blue)

StyleObj
	var
		FontObj/font
		alpha = 0xFF
		ColorObj/color = new()
		bgalpha = 0xFF
		bgcolor = null
		oalpha = 0xFF
		ocolor = null
		othickness = 1
		width = 0
		height = 0
		textalign = TEXT_LEFT
		textwrap = 0
	proc
		SetFont(FontObj/font)
			src.font = font
		SetAlpha(alpha)
			src.alpha = alpha
		SetColor(red,green,blue)
			src.color.SetColor(red,green,blue)
		SetBackgroundColor(bgcolor)
			src.bgcolor = bgcolor
		SetOutlineColor(ocolor)
			src.ocolor = ocolor
		SetOutlineThickness(othickness)
			src.othickness = othickness
		SetSize(width,height)
			src.width = width
			src.height = height
		SetTextAlignment(textalign)
			src.textalign = textalign

FontObj
	parent_type = /icon
	var
		cwidth = 0
		cheight = 0
		hspacing = 0
		vspacing = 0
		fontmode = 0x00
		list
			textobjs = new()
	New(fontfile=SBYIO_DEFAULTFONT,cwidth=0,cheight=0,hspacing=2,vspacing=2,fontmode=FONT_FIXED)
		src.icon = fontfile
		if(cwidth > 0)
			src.cwidth = cwidth
		else
			src.cwidth = Width()
		if(cheight > 0)
			src.cheight = cheight
		else
			src.cheight = Height()
		src.hspacing = hspacing
		src.vspacing = vspacing
		src.fontmode = fontmode
	proc
		SetSize(cwidth,cheight)
			if(cwidth > 0)
				src.cwidth = cwidth
			else
				src.cwidth = Width()
			if(cheight > 0)
				src.cheight = cheight
			else
				src.cheight = Height()
		SetSpacing(hspacing,vspacing)
			src.hspacing = hspacing
			src.vspacing = vspacing
		Update()
			for(var/TextObj/TO in textobjs)
				TO.ChangeText(null)

AnimStage
	var
		alpha
		ColorObj/color
		time
		loop
		easing
	proc
		SetAlpha(alpha)
			src.alpha = alpha
		SetColor(ColorObj/color)
			src.color = color
		SetTime(time)
			src.time = time
		SetLoop(loop)
			src.loop = loop
		SetEasing(easing)
			src.easing = easing
		GetStageArgData()
			var/list/stageargs = new()
			if(alpha != null)
				stageargs["alpha"] = alpha
			if(color != null)
				stageargs["color"] = src.color.GetColor()
			if(time != null)
				stageargs["time"] = time
			if(loop != null)
				stageargs["loop"] = loop
			if(easing != null)
				stageargs["easing"] = easing
			return stageargs

AnimState
	var
		list/stages = new()
	proc
		AddStage(AnimStage/stage)
			src.stages += stage
		ChangeStage(stage_idx,AnimStage/stage)
			if(stage_idx <= length(stages) && stage_idx >= 1)
				src.stages[stage_idx] = stage
		GetStage(stage_idx)
			return stages[stage_idx]

TextIcon
	parent_type = /icon
	var
		StyleObj/style
		text
		icon/OTI
	New(text,style=null)
		if(style == null)
			src.style = new()
		else
			src.style = style
		src.ChangeText(text)
	proc
		ChangeText(text)
			if(src.text != text && text != null)
				src.text = text
			OTI = new('Special.dmi')
			var/lines = 1
			var/blpos = 1
			var/ccpos = 0
			var/cnlpos = findtext(src.text,"\n")
			var/mwidth = 0
			var/FontObj/font = style.font
			while(cnlpos != 0)
				if(ccpos == 0)
					ccpos = 1
				var/cwidth = cnlpos-ccpos
				if(cwidth > mwidth)
					mwidth = cwidth
					blpos = ccpos
				lines++
				ccpos = cnlpos+1
				cnlpos = findtext(src.text,"\n",ccpos)
			if(lines == 1)
				mwidth = length(src.text)
			var/iconwidth = 0
			var/iconheight = 0
			if(style.height == 0)
				iconheight = (lines*(style.font.cheight+style.font.vspacing))-style.font.vspacing
			else
				iconheight = style.height
			if(style.width == 0)
				if(font.fontmode == FONT_VAR)
					for(var/C = blpos; C <= (blpos+mwidth)-1; C++)
						var/start = 0
						var/end = 0
						var/char = copytext(src.text,C,C+1)
						if(char == "\n")
							continue
						var/vchar
						if(char == " ")
							vchar = "spv"
						else
							vchar = "[char]v"
						var/dfwidth = font.Width()
						if(vchar in icon_states(font))
							for(var/W = 1; W <= dfwidth; W++)
								if(font.GetPixel(W,1,vchar) != null)
									if(start == 0)
										start = W
										continue
									if(end == 0)
										end = W
										break
							var/nwidth = (end-start)+1
							var/anwidth = round((font.cwidth/dfwidth)*nwidth)
							if(anwidth < 1)
								anwidth = 1
							iconwidth += anwidth
						else
							iconwidth += font.cwidth
						if(C < length(src.text))
							iconwidth += font.hspacing
				else if(font.fontmode == FONT_FIXED)
					iconwidth = (mwidth*(font.cwidth+font.hspacing))-font.hspacing
			else
				iconwidth = style.width
			OTI.Scale(iconwidth,iconheight)
			var/cline = 1
			var/cx = 1
			for(var/C = 1; C <= length(src.text); C++)
				var/char = copytext(src.text,C,C+1)
				if(char == "\n")
					cline++
					cx = 1
					continue
				var/icon/ichar = new(font,char)
				var/vchar
				if(char == " ")
					vchar = "spv"
				else
					vchar = "[char]v"
				if(font.fontmode == FONT_VAR && vchar in icon_states(font))
					var/start = 0
					var/end = 0
					var/dfwidth = font.Width()
					for(var/W = 1; dfwidth; W++)
						if(font.GetPixel(W,1,vchar) != null)
							if(start == 0)
								start = W
								continue
							if(end == 0)
								end = W
								break
					var/nwidth = (end-start)+1
					var/anwidth = round((font.cwidth/dfwidth)*nwidth)
					if(anwidth < 1)
						anwidth = 1
					if(start > 1)
						ichar.Shift(WEST,start-1)
					var/icon/nichar = new('Special.dmi')
					nichar.Scale(nwidth,font.Height())
					nichar.Blend(ichar,ICON_UNDERLAY)
					nichar.Scale(anwidth,font.cheight)
					OTI.Blend(nichar,ICON_OR,cx,((lines-cline)*(font.cheight+font.vspacing))+1)
					cx += anwidth+font.hspacing
				else
					ichar.Scale(font.cwidth,font.cheight)
					OTI.Blend(ichar,ICON_OR,cx,((lines-cline)*(font.cheight+font.vspacing))+1)
					cx += font.cwidth+font.hspacing
			icon = OTI
		SetColor(red,green,blue)
			src.Blend(src.style.color.GetColor(),ICON_SUBTRACT)
			src.style.color.SetColor(red,green,blue)
			src.Blend(src.style.color.GetColor())

/*
VisualTextIcon
	parent_type = /TextIcon
	var
		icon/VTI
		width
		height
		ciconstate = ""
		cdelay
		frame = 1
	New(text,StyleObj/style)
		src.cdelay = world.tick_lag
		..(text,style)
	ChangeText(text)
		..(text)
		var/changeflag = 0x00
		var/width = src.OTI.Width()
		var/height = src.OTI.Height()
		if(width > src.width)
			src.width = width
			changeflag = 0x01
		if(height > src.height)
			src.height = height
			changeflag = 0x01
		if(changeflag & 0x01)
			var/icon/NVTI = new('Special.dmi')
			NVTI.Scale(src.width,src.height)
			if(src.VTI != null)
				NVTI.Blend(src.VTI)
			src.VTI = NVTI
		if(ciconstate == "" || ciconstate == null)
			src.VTI.Insert(src.OTI,"",null,0,0,null)
		else
			src.VTI.Insert(src.OTI,"[ciconstate]",null,src.frame++,0,src.cdelay)
	SetColor(red,green,blue)
		..(red,green,blue)
		if(src.ciconstate == "" || src.ciconstate == null)
			src.VTI.Insert(src.icon,"",null,0,0,null)
		else
			src.VTI.Insert(src.icon,"[ciconstate]",null,src.frame++,0,src.cdelay)
	SetAlpha(alpha)
		..(alpha)
		if(src.ciconstate == "" || src.ciconstate == null)
			src.VTI.Insert(src.icon,"",null,0,0,null)
		else
			src.VTI.Insert(src.icon,"[ciconstate]",null,src.frame++,0,src.cdelay)
	proc
		SetIconState(niconstate="")
			ciconstate = niconstate
			frame = 1
			src.VTI.Insert(src.icon,"[ciconstate]",null,src.frame,0,src.cdelay)
		SetDelay(delay=world.tick_lag)
			cdelay = delay
		ChangeColor(red,green,blue,rate=1)
			var/cred = style.color.red
			var/cgreen = style.color.green
			var.cblue = style.color.blue
			while(cred != red || cgreen != green || cblue != blue)
				if(red > cred)
					cred += rate
					if(cred > red)
						cred = red
				else if(red < cred)
					cred -= rate
					if(red > cred)
						cred = red
				if(green > cgreen)
					cgreen += rate
					if(cgreen > green)
						cgreen = green
				else if(green < cgreen)
					cgreen -= rate
					if(green > cgreen)
						cgreen = green
				if(blue > cblue)
					cblue += rate
					if(cblue > blue)
						cblue = blue
				else if(blue < cblue)
					cblue -= rate
					if(blue > cblue)
						cblue = blue
				SetColor(cred,cgreen,cblue)
		ChangeAlpha(nalpha=0xFF,rate=1)
			var/calpha = style.alpha
			while(calpha != nalpha)
				if(nalpha > calpha)
					calpha += rate
					if(calpha > nalpha)
						calpha = nalpha
				else if(nalpha < calpha)
					calpha -= rate
					if(nalpha > calpha)
						calpha = nalpha
				SetAlpha(calpha)
*/

TextObj
	parent_type = /obj
	var
		StyleObj/style
		TextIcon/TOI
		list/animstates = new()
	New(text,StyleObj/style,mopacity=1)
		src.style = style
		src.style.font.textobjs += src
		src.color = src.style.color.GetColor()
		src.alpha = src.style.alpha
		src.mouse_opacity = mopacity
		src.ChangeText(text)
	proc
		ChangeText(text)
			if(TOI == null)
				TOI = new(text,style)
			else
				TOI.ChangeText(text)
			icon = TOI
		SetColor(color)
			src.color = color
		SetAlpha(alpha)
			src.alpha = alpha
		SetMapLoc(x,y,z)
			loc = locate(x,y,z)
		SetScreenLoc(x,px,y,py)
			screen_loc = "[x]:[px],[y]:[py]"
		InsertAnimationState(as_name,AnimState/anim_state)
			animstates[as_name] = anim_state
		GetAnimationState(as_name)
			return animstates[as_name]
		StartAnimation(as_name,image/img=null)
			var/AnimState/anim_state = animstates[as_name]
			for(var/stage_idx = 1; stage_idx <= length(anim_state.stages); stage_idx++)
				var/AnimStage/stage = anim_state.GetStage(stage_idx)
				var/list/stageargs = new()
				if(stage_idx == 1)
					if(img == null)
						stageargs += src
					else
						stageargs += img
				stageargs += stage.GetStageArgData()
				animate(arglist(stageargs))

/*
VisualTextObj
	parent_type = /obj
	New(VisualTextIcon/VTI)
		src.icon = VTI.VTI
	proc
		SetIconState(icon_state)
			src.icon_state = icon_state
		SetMapLoc(x,y,z)
			loc = locate(x,y,z)
		SetScreenLoc(x,px,y,py)
			screen_loc = "[x]:[px],[y]:[py]"
*/

ItemTextObj
	parent_type = /TextObj
	var
		StyleObj/hstyle
		command
		icon/hicon
		image/hcimage
		id
		MenuObj/MO
		icon/HBG
		list/vlist
	New(text,StyleObj/style,StyleObj/hstyle,command=null,hicon=null,vlist=null)
		src.hstyle = hstyle
		src.command = command
		if(hicon != null)
			src.hicon = new(hicon)
			src.hcimage = image(src.hicon,src)
			hcimage.pixel_x -= (src.hicon.Width() + hstyle.font.hspacing)
		..(text,style,2)
		src.vlist = vlist
		var/AnimState/AS = new()
		var/AnimStage/AS_S = new()
		AS_S.SetColor(style.color)
		AS.AddStage(AS_S)
		InsertAnimationState("Unfocus",AS)
		AS = new()
		AS_S = new()
		AS_S.SetColor(hstyle.color)
		AS.AddStage(AS_S)
		InsertAnimationState("Focus",AS)
	MouseEntered()
		if(MO != null)
			if(!MO.keyboardonly)
				Select()
		else
			Select()
	MouseExited()
		if(MO != null)
			if(!MO.keyboardonly)
				Unselect()
		else
			Unselect()
	Click()
		..()
		if(MO != null)
			if(!MO.keyboardonly)
				Command()
		else
			Command()
	ChangeText(text)
		if(TOI == null)
			TOI = new(text,style)
		else
			TOI.ChangeText(text)
		icon = TOI
		/*
		var/icon/NTOI = new('Special.dmi')
		var/lines = 1
		var/iconwidth = 0
		var/iconheight = 0
		var/startx = 1
		var/starty = 1
		var/FontObj/font = hstyle.font
		if(hstyle.bgcolor != null || hstyle.ocolor != null)
			iconwidth = TOI.Width()+2+(hstyle.othickness*2)
			iconheight = TOI.Height()+2+(hstyle.othickness*2)
		else
			iconwidth = TOI.Width()
			iconheight = TOI.Height()
		if(hicon != null)
			iconwidth += hicon.Width() + font.hspacing
			startx += hicon.Width() + font.hspacing
			var/otsize = (lines*(font.cheight + font.vspacing))-font.vspacing
			if(hicon.Height() < otsize)
				var/midpoint = round((hicon.Height() + otsize) / 2)
				var/incy = midpoint - hicon.Height()
				starty += incy
		NTOI.Scale(iconwidth,iconheight)
		if(hstyle.ocolor != null || hstyle.bgcolor != null)
			HBG = new('Special.dmi')
			HBG.Scale(iconwidth-(startx-1),iconheight)
			if(hstyle.ocolor != null)
				HBG.DrawBox(hstyle.ocolor,1,1,iconwidth-(startx-1),iconheight)
			if(hstyle.bgcolor == null)
				HBG.DrawBox(null,1+hstyle.othickness,1+hstyle.othickness,iconwidth-(startx-1)-hstyle.othickness,iconheight-hstyle.othickness)
			else
				if(hstyle.ocolor != null)
					HBG.DrawBox(hstyle.bgcolor,1+hstyle.othickness,1+hstyle.othickness,iconwidth-(startx-1)-hstyle.othickness,iconheight-hstyle.othickness)
				else
					HBG.DrawBox(hstyle.bgcolor,1,1,iconwidth-(startx-1),iconheight)
			NTOI.Blend(TOI.icon,ICON_OVERLAY,startx+1+hstyle.othickness,2+hstyle.othickness)
		else
			NTOI.Blend(TOI.icon,ICON_OVERLAY,startx)
		var/icon/TOIF = new(NTOI)
		TOIF.Blend(style.color.GetColor(),ICON_SUBTRACT)
		TOIF.Blend(hstyle.color.GetColor())
		if(hstyle.ocolor != null || hstyle.bgcolor != null)
			TOIF.Blend(HBG,ICON_UNDERLAY,startx)
		if(hicon != null)
			if(hstyle.ocolor != null || hstyle.bgcolor != null)
				TOIF.Blend(hicon,ICON_UNDERLAY,1,starty+2)
			else
				TOIF.Blend(hicon,ICON_UNDERLAY,1,starty)
		NTOI.Insert(TOIF,"Focus",null,0,0,null)
		icon = NTOI
		*/
	SetColor(red,green,blue)
		/*
		var/icon/NTOI = new(TOI)
		var/icon/TOIF = new(NTOI,"")
		TOIF.Blend(src.style.color.GetColor(),ICON_SUBTRACT)
		src.style.color.SetColor(red,green,blue)
		TOIF.Blend(src.style.color.GetColor())
		NTOI.Insert(TOIF,"",null,0,0,0)
		TOI = NTOI
		icon = NTOI
		*/
	proc
		SetHighlightColor(thcolor,ohcolor,ihcolor)
			/*
			var/icon/NTOI = new(TOI)
			var/icon/TOIF = new(NTOI,"")
			var/startx = 1
			var/starty = 1
			var/FontObj/font = hstyle.font
			if(hicon != null)
				startx += hicon.Width()
				if(hicon.Height() < font.cheight)
					var/midpoint = round((hicon.Height() + font.cheight) / 2)
					var/incy = midpoint - hicon.Height()
					starty += incy
			TOIF.Blend(src.hstyle.color,ICON_SUBTRACT)
			src.hstyle.color = thcolor
			TOIF.Blend(src.hstyle.color)
			if(hstyle.ocolor != null || hstyle.bgcolor != null)
				var/icon/NHBG = new('Special.dmi')
				var/bgwidth = TOIF.Width() - (startx-1)
				var/bgheight = TOIF.Height()
				NHBG.Scale(bgwidth,bgheight)
				if(ohcolor != null)
					src.hstyle.ocolor = ohcolor
					if(hstyle.ocolor != null)
						NHBG.DrawBox(src.hstyle.ocolor,1,1,bgwidth,bgheight)
					if(hstyle.bgcolor == null)
						NHBG.DrawBox(null,2,2,bgwidth-1,bgheight-1)
				if(ihcolor != null)
					src.hstyle.bgcolor = ihcolor
					if(hstyle.ocolor == null)
						NHBG.DrawBox(src.hstyle.bgcolor,1,1,bgwidth,bgheight)
					else
						NHBG.DrawBox(src.hstyle.bgcolor,2,2,bgwidth-1,bgheight-1)
				TOIF.Blend(HBG,ICON_UNDERLAY,startx)
			if(hicon != null)
				if(hstyle.ocolor != null || hstyle.bgcolor != null)
					TOIF.Blend(hicon,ICON_UNDERLAY,1,starty+2)
				else
					TOIF.Blend(hicon,ICON_UNDERLAY,1,starty)
			NTOI.Insert(TOIF,"Focus",null,0,0,0)
			icon = NTOI
			*/
		Select()
			/*
			icon_state = "Focus"
			color = hstyle.color.GetColor()
			*/
			StartAnimation("Focus")
			if(hcimage != null)
				if(vlist != null)
					vlist << hcimage
				else
					usr << hcimage
			// src.overlays += hicon
			if(MO != null)
				if(MO.cid != id)
					if(MO.cid > 0)
						var/ItemTextObj/PIT = MO.menulist[MO.cid]
						PIT.Unselect()
					MO.cid = id
		Unselect()
			/*
			icon_state = ""
			color = style.color.GetColor()
			*/
			StartAnimation("Unfocus")
			if(hcimage != null)
				if(vlist != null)
					for(var/mob/M in vlist)
						if(M.client)
							M.client.images -= hcimage
				else
					usr.client.images -= hcimage

		Command()
			var/list/cmd = new()
			cmd["command"] = "[command]"
			winset(usr,null,list2params(cmd))

MenuObj
	parent_type = /DelayInputObj
	delay = 0.4
	var
		hspacing
		vspacing
		StyleObj/style
		StyleObj/hstyle
		icon/hicon
		keyboardonly
		spacingmode
		cid = 0
		list
			menulist = new()
	New(StyleObj/style,StyleObj/hstyle,hspacing,vspacing,hicon,keyboardonly,spacingmode)
		src.style = style
		src.hstyle = hstyle
		src.hspacing = hspacing
		src.vspacing = vspacing
		src.hicon = new(hicon)
		src.keyboardonly = keyboardonly
		src.spacingmode = spacingmode
		if(src.keyboardonly > 1)
			src.keyboardonly = 1
		else if(src.keyboardonly < 0)
			src.keyboardonly = 0
	Focus(client/C)
		if(length(menulist) > 0 && keyboardonly)
			var/ItemTextObj/CIT = menulist[1]
			CIT.Select()
	Unfocus(client/C)
		var/ItemTextObj/ITO = GetSelectedMenuItem()
		if(ITO != null)
			ITO.Unselect()
	Input(key,client/C)
		var/r = ..()
		if(r == 0)
			return
		var/ItemTextObj/IT
		if(key != "Enter")
			var/pid = cid
			switch(spacingmode)
				if(MVSPACING)
					if(key == "Up")
						pid--
						if(pid < 1)
							pid = length(menulist)
					else if(key == "Down")
						pid++
						if(pid > length(menulist))
							pid = 1
				if(MHSPACING)
					if(key == "Left")
						pid--
						if(pid < 1)
							pid = length(menulist)
					else if(key == "Right")
						pid++
						if(pid > length(menulist))
							pid = 1
			IT = menulist[pid]
			IT.Select()
		else
			if(cid > 0)
				IT = menulist[cid]
				IT.Command()
		Delay()
	proc
		AddItem(text,command)
			var/ItemTextObj/NI = new(text,style,hstyle,command,hicon,null)
			menulist += NI
			NI.id = length(menulist)
			NI.MO = src
			if(NI.id == 1 && keyboardonly)
				NI.Select()
		SetMenuLoc(sx,spx,sy,spy)
			var/mipos = 0
			var/diwidth = 0
			var/diheight = 0
			var/cspx = spx
			var/FontObj/font = style.font
			if(isnum(world.icon_size))
				diwidth = world.icon_size
				diheight = world.icon_size
			else
				var/cirhpos = findtext(world.icon_size,"x",1)
				var/cirvpos = findtext(world.icon_size,"x",1)+1
				diwidth = text2num(copytext(world.icon_size,1,cirhpos))
				diheight = text2num(copytext(world.icon_size,cirvpos))
			for(var/ItemTextObj/ITO in menulist)
				var/nsx = sx
				var/nspx = cspx
				var/nsy = sy
				var/nspy = spy-(mipos*(font.cheight+vspacing))
				while(nspx > diwidth)
					nspx -= diwidth
					nsx++
				while(nspy < 0)
					nspy += diheight
					nsy--
				cspx += ((font.cwidth+font.hspacing)*length(ITO.text))+hspacing
				if(hicon != null)
					cspx += hicon.Width()+font.hspacing
				switch(spacingmode)
					if(MVSPACING)
						ITO.SetScreenLoc(sx,spx,nsy,nspy)
					if(MHSPACING)
						ITO.SetScreenLoc(nsx,nspx,sy,spy)
				mipos++
		GetMenuList()
			return menulist
		GetSelectedMenuItem()
			if(cid != 0)
				return menulist[cid]
			else
				return null

InputObj
	parent_type = /obj
	var
		client/owner
	proc
		SetClient(client/owner)
			src.owner = owner
		Focus()
		Unfocus()
		Input(key)
		Release(key)

DelayInputObj
	parent_type = /InputObj
	var
		delay = 0.5
		counter = 0
		held = 0
	Input(key)
		if(counter < delay && counter > 0)
			return 0
		else
			return 1
	Release(key)
		held = 0
		counter = delay
	proc
		Delay()
			if(held == 0)
				held = 1
				spawn while(counter < delay)
					sleep(world.tick_lag)
					counter += world.tick_lag / 10
				counter = 0

TextInputObj
	parent_type = /DelayInputObj
	var
		itype
		style
		ocolor
		icolor
		command
		imode
		iflag = 0x00
		length = 0
		vlength = 0
		vstart = 1
		vend
		cpos = 1
		icon/IBG
		icon/ITOI
		icon/IC
		FontObj/font
		list
			vilist = new()
			idata = new()
	New(client/owner,text,FontObj/font,color,alpha,length,itype,style,ocolor,icolor,command,imode,vlength)
		src.SetClient(owner)
		src.font = font
		src.font.textobjs += src
		src.alpha = alpha
		src.color = color
		src.mouse_opacity = 2
		src.length = length
		src.style = style
		src.itype = itype
		src.command = command
		src.imode = imode
		if(vlength > 0 && src.imode == IMODE1)
			src.vlength = vlength
		else
			src.vlength = src.length
		if(src.imode == IMODE1)
			src.vend = src.vlength
		src.IC = new(src.font)
		src.IC.Scale(src.font.cwidth,src.font.cheight)
		src.IC.Blend(src.color)
		for(var/IS in icon_states(src.IC))
			var/icon/I = new(src.IC,"[IS]")
			var/icon/IF = new(src.IC,"_")
			src.IC.Insert(I,"[IS]:F",null,1,0,5)
			src.IC.Insert(IF,"[IS]:F",null,2,0,5)
		if(font.fontmode == FONT_VAR)
			for(var/vchar in icon_states(src.font))
				if(length(vchar) < 2)
					continue
				var/vpos = findtextEx(vchar,"v",length(vchar))
				if(vpos == 0)
					continue
				else
					var/start = 0
					var/end = 0
					var/dfwidth = src.font.Width()
					var/cchar = copytext(vchar,1,vpos)
					if(cchar == "sp")
						cchar = " "
					var/icon/I = new(src.font,"[cchar]")
					var/icon/NI = new('Special.dmi')
					var/icon/IF = new(src.font,"_")
					for(var/W = 1; W <= dfwidth; W++)
						if(src.font.GetPixel(W,1,vchar) != null)
							if(start == 0)
								start = W
								continue
							if(end == 0)
								end = W
								break
					var/nwidth = (end-start)+1
					var/anwidth = round((font.cwidth/dfwidth)*nwidth)
					if(anwidth < 1)
						anwidth = 1
					if(start > 1)
						I.Shift(WEST,start-1)
					NI.Scale(nwidth,src.font.Height())
					NI.Blend(I,ICON_UNDERLAY)
					NI.Scale(anwidth,src.font.cheight)
					NI.Blend(src.color)
		var/iconwidth = ((src.vlength+1)*(src.font.cwidth+src.font.hspacing))+2
		var/iconheight = src.font.cheight+4
		src.ITOI = new('Special.dmi')
		src.ITOI.Scale(iconwidth,iconheight)
		if((src.style & OUTLINE) || (src.style & FILL))
			src.IBG = new('Special.dmi')
			src.IBG.Scale(iconwidth,iconheight)
			if(src.style & OUTLINE)
				src.ocolor = ocolor
				src.IBG.DrawBox(src.ocolor,1,1,iconwidth,iconheight)
			if(src.style & FILL)
				src.icolor = icolor
				src.IBG.DrawBox(src.icolor,2,2,iconwidth-1,iconheight-1)
			src.ITOI.Insert(IBG,"")
		src.icon = src.ITOI
		var/icon/SIL = new('Special.dmi')
		SIL.Scale(iconwidth,iconheight)
		var/image/I = image(SIL,src)
		I.layer = src.layer+0x100
		owner.images += I
		src.ChangeText(text)
	Click(location,control,params)
		var/list/pr = params2list(params)
		var/iconx = text2num(pr["icon-x"])
		var/ppos = cpos
		cpos = 1
		owner.SetInputFocus(src)
		for(var/cp = 1; cp <= length(text); cp++)
			var/iconxpos = ((cp-1)*(font.cwidth+font.hspacing))
			var/niconpos = (cp*(font.cwidth+font.hspacing))
			if(iconx >= iconxpos && iconx <= niconpos)
				break
			cpos++
		var/pchar = copytext(text,ppos,ppos+1)
		if(length(idata) > 0)
			var/image/P = idata[ppos]
			owner.images -= idata
			P.icon_state = "[pchar]"
		SetCursor()
		owner.images += idata
	Focus()
		iflag |= 0x01
	Unfocus()
		iflag &= ~(0x01)
		var/image/CI = idata[cpos]
		var/cchar = copytext(text,cpos,cpos+1)
		CI.icon_state = "[cchar]"
	Input(key)
		var/r = ..()
		if(r == 0)
			return
		if(key == "Left")
			owner.images -= idata
			CursorLeft()
			owner.images += idata
		else if(key == "Right")
			owner.images -= idata
			CursorRight()
			owner.images += idata
		else if(key == "Back")
			owner.images -= idata
			DeleteChar(0)
			owner.images += idata
		else if(key == "Delete")
			owner.images -= idata
			DeleteChar(1)
			owner.images += idata
		else if(key == "Enter")
			Command()
		else if(length(key) == 1)
			var/char = key
			if(itype == NUM)
				var/v = text2num(char)
				if(v == null)
					char = null
			if(char != null)
				owner.images -= idata
				AddChar(char)
				owner.images += idata
		Delay()

	proc
		ChangeText(text)
			if(src.text != text)
				if(src.owner != null)
					src.owner.images -= idata
				if(src.itype == TEXT || (src.itype == NUM && text2num(text) != null))
					src.text = text
					for(var/c = 1; c <= length(src.text); c++)
						var/char = copytext(src.text,c,c+1)
						src.AddChar(char)
				if(src.owner != null)
					owner.images += idata
		SetScreenLoc(x,px,y,py)
			screen_loc = "[x]:[px],[y]:[py]"
		GetText()
			return text
		SetCursor()
			var/iconpos = ((cpos-1)*(font.cwidth+font.hspacing))+2
			var/cchar = copytext(text,cpos,cpos+1)
			var/cis
			if(iflag & 0x01)
				cis = "[cchar]:F"
			else
				cis = "[cchar]"
			var/image/I
			if(length(idata) < cpos)
				I = image(IC,src,cis)
				I.pixel_x = iconpos
				I.pixel_y = 2
				idata += I
			else
				I = idata[cpos]
				I.icon_state = cis
		AddChar(char)
			if(cpos <= length)
				var/image/P
				if(length(idata) > 0)
					P = idata[cpos]
					P.icon_state = "[char]"
				else
					var/iconpos = ((cpos-1)*(font.cwidth+font.hspacing))+2
					/*
					var/vchar
					if(char == " ")
						vchar = "spv"
					else
						vchar = "[char]v"
					if(font.fontmode == FONT_VAR && vchar in icon_states(font))
						var/dfwidth = font.Width()
						// for(var/W = 1; W <= dfwidth; W++)

					else
					*/
					P = image(IC,src,"[char]")
					P.pixel_x = iconpos
					P.pixel_y = 2
					idata += P
				if(cpos <= length(text))
					var/ntext = copytext(text,1,cpos)
					ntext += char
					if(cpos < length(text))
						ntext += copytext(text,cpos+1)
					text = ntext
				else
					text += char
				cpos++
				SetCursor()
		DeleteChar(cpflag)
			if(cpos > 1 || ((cpflag & 0x01) && length(text) > 0))
				if(!(cpflag & 0x01))
					if(iflag & 0x01)
						var/image/P = idata[cpos]
						idata -= P
					cpos--
				var/ntext
				if(cpos < length(text))
					ntext = copytext(text,cpos+1,length(text)+1)
					for(var/cp = length(idata); cp >= cpos+1; cp--)
						var/image/P = idata[cp]
						idata -= P
				text = copytext(text,1,cpos)
				if(ntext != null)
					var/tcpos = cpos
					for(var/ccpos = 1; ccpos <= length(ntext); ccpos++)
						var/char = copytext(ntext,ccpos,ccpos+1)
						AddChar(char)
						if(ccpos == length(ntext))
							var/image/NI = idata[cpos]
							NI.icon_state = ""
					cpos = tcpos
				SetCursor()
		CursorLeft()
			if(cpos > 1)
				var/image/P = idata[cpos]
				if(cpos <= length(text))
					var/pchar = copytext(text,cpos,cpos+1)
					P.icon_state = "[pchar]"
				else
					P.icon_state = ""
				cpos--
				SetCursor()
		CursorRight()
			if(cpos <= length(text))
				var/image/P = idata[cpos]
				var/pchar = copytext(text,cpos,cpos+1)
				P.icon_state = "[pchar]"
				cpos++
				SetCursor()
		Command()
			var/list/cmd = new()
			cmd["command"] = "[command]"
			winset(usr,null,list2params(cmd))

MapTextObj
	parent_type = /obj
	var
		style
		StyleObj/style2 = new()
		icon/mzone = new('Special.dmi')
	New(text,style=null,width=0,height=0,mopacity=1)
		src.style = "[style]"
		src.ChangeText(text)
		src.mouse_opacity = mopacity
		src.SetSize(width,height)
	proc
		ChangeText(text)
			var/styledata = "<style>body{color: [style2.color.GetColor()]}"
			src.text = text
			src.maptext = "<style>body{[style]}</style>[src.text]"
		ChangeStyle(style)
			src.style = style
			src.ChangeText(maptext)
		SetSize(width,height)
			maptext_width = width
			maptext_height = height
			mzone.Scale(width,height)
			icon = mzone
		SetMapLoc(x,y,z)
			loc = locate(x,y,z)
		SetScreenLoc(x,px,y,py)
			screen_loc = "[x]:[px],[y]:[py]"

MapItemTextObj
	parent_type = /MapTextObj
	var
		hstyle
		command
		flag = 0x00
	New(text,style=null,width=0,height=0,hstyle=null,command=null)
		src.hstyle = hstyle
		src.command = command
		..(text,style,width,height,2)
	ChangeText(text)
		if(!(flag & 0x01))
			..(text)
		else
			src.text = text
			src.maptext = "<style>body{[hstyle]}</style>[src.text]"
	MouseEntered()
		flag |= 0x01
		ChangeText(text)
	MouseExited()
		flag &= ~(0x01)
		ChangeText(text)
	Click()
		Command()
	proc
		Command()
			var/list/cmd = new()
			cmd["command"] = "[command]"
			winset(usr,null,list2params(cmd))

MapTextInputObj
	parent_type = /DelayInputObj
	var
		icon/IBG
	New()
	Focus()
	Unfocus()
	Input(key)

DisplayObj
	proc
		Display(client/C)
			if(C != null)
				for(var/V in vars)
					var/vdata = vars["[V]"]
					if(vdata != null)
						if(istype(vdata,/obj) && !istype(vdata,/MenuObj))
							var/obj/O = vdata
							if(O.screen_loc != null)
								C.screen += O
						else if(istype(vdata,/MenuObj))
							var/MenuObj/MO = vdata
							C.screen += MO.GetMenuList()
		Clear(client/C)
			if(C != null)
				for(var/V in vars)
					var/vdata = vars["[V]"]
					if(vdata != null)
						if(istype(vdata,/obj) && !istype(vdata,/MenuObj))
							var/obj/O = vdata
							if(O in C.screen)
								C.screen -= O
						else if(istype(vdata,/MenuObj))
							var/MenuObj/MO = vdata
							var/list/ML = MO.GetMenuList()
							for(var/ItemTextObj/IT in ML)
								if(IT in C.screen)
									C.screen -= IT

/*
GroupObj
	parent_type = /InputObj
	var
		cid = 1
		list
			itemlist = new()
	Focus(client/C)
		if(length(itemlist) > 0)
			var/obj/item = itemlist[1]
			for(var/IS in icon_states(item))
				if(IS == "Focus")
					item = IS
					break
	Unfocus(client/C)
	Input(key,client/C)
		if(length(itemlist) > 1)
			if(key == "Up")
				cid--
				if(cid < 1)
					cid = length(itemlist)
			else if(key == "Down")
				cid++
				if(cid > length(itemlist))
					cid = 1
	proc
		AddItem(obj/item)
			itemlist += item
*/

atom
	Click()
		..()
		if(usr.client.IOFocus != null)
			if(!istype(usr.client.IOFocus,/MenuObj))
				usr.client.ClearInputFocus()

client
	var
		InputObj/IOFocus
		cwindow
		cmacro
		isflag = 0x00
	New()
		..()
		mob.loc = null
		cwindow = winget(src,null,"focus")
		var/cwndchk = findtext(cwindow,".")
		if(cwndchk != 0)
			cwindow = copytext(cwindow,1,cwndchk)
		cmacro = winget(src,cwindow,"macro")
		winclone(src,"macro","inputmodemacro")
		SetKeyInputMacro("UAKR","NORTH","Up")
		SetKeyInputMacro("DAKR","SOUTH","Down")
		SetKeyInputMacro("LAKR","WEST","Left")
		SetKeyInputMacro("RAKR","EAST","Right")
		SetKeyInputMacro("BKKR","BACK","Back")
		SetKeyInputMacro("DKKR","DELETE","Delete")
		SetKeyInputMacro("SPKR","SPACE"," ")
		SetKeyInputMacro("ENKR","RETURN","Enter")
		SetKeyInputMacro("GAKR","`","`")
		SetKeyInputMacro("TLKR","SHIFT+`","~")
		SetKeyInputMacro("HPKR","-","-")
		SetKeyInputMacro("UDKR","SHIFT+-","_")
		SetKeyInputMacro("EQKR","=","=")
		SetKeyInputMacro("LBRKR","\[","\[")
		SetKeyInputMacro("LBCKR","SHIFT+\[","{")
		SetKeyInputMacro("RBRKR","]","]")
		SetKeyInputMacro("RBCKR","SHIFT+]","}")
		SetKeyInputMacro("SBKR","\\","\\\\")
		SetKeyInputMacro("CAKR","SHIFT+\\","|")
		SetKeyInputMacro("SCKR",";",";")
		SetKeyInputMacro("COKR","SHIFT+;",":")
		SetKeyInputMacro("AEKR","'","'")
		SetKeyInputMacro("QOKR","SHIFT+'","\\\"")
		SetKeyInputMacro("CMKR",",",",")
		SetKeyInputMacro("LTKR","SHIFT+,","<")
		SetKeyInputMacro("PDKR",".",".")
		SetKeyInputMacro("GTKR","SHIFT+.",">")
		SetKeyInputMacro("SFKR","/","/")
		SetKeyInputMacro("QMKR","SHIFT+/","?")
		SetKeyInputMacro("PLKR","SHIFT+=","+")
		SetKeyInputMacro("0SKR","SHIFT+0",")")
		SetKeyInputMacro("1SKR","SHIFT+1","!")
		SetKeyInputMacro("2SKR","SHIFT+2","@")
		SetKeyInputMacro("3SKR","SHIFT+3","#")
		SetKeyInputMacro("4SKR","SHIFT+4","$")
		SetKeyInputMacro("5SKR","SHIFT+5","%")
		SetKeyInputMacro("6SKR","SHIFT+6","^")
		SetKeyInputMacro("7SKR","SHIFT+7","&")
		SetKeyInputMacro("8SKR","SHIFT+8","*")
		SetKeyInputMacro("9SKR","SHIFT+9","(")
		for(var/nK = 0; nK <= 9; nK++)
			SetKeyInputMacro("[nK]KR","[nK]","[nK]")
		for(var/uK = text2ascii("A"); uK <= text2ascii("Z"); uK++)
			var/cK = ascii2text(uK)
			SetKeyInputMacro("[cK]SKR","SHIFT+[cK]","[cK]")
		for(var/lK = text2ascii("a"); lK <= text2ascii("z"); lK++)
			var/cK = ascii2text(lK)
			SetKeyInputMacro("[cK]KR","[cK]","[cK]")
	proc
		SetKeyInputMacro(macroname,key,input)
			var/list/keyi = new()
			keyi["parent"] = "inputmodemacro"
			keyi["name"] = "[key]+REP"
			keyi["command"] = "KeyPress \"[input]\""
			winset(src,macroname,list2params(keyi))
			keyi["name"] = "[key]+UP"
			keyi["command"] = "KeyRelease \"[input]\""
			winset(src,"[macroname]+RL",list2params(keyi))
		SetInputFocus(InputObj/IO)
			cwindow = winget(src,null,"focus")
			while(cwindow == "")
				sleep(1)
				cwindow = winget(src,null,"focus")
			var/cwndchk = findtext(cwindow,".")
			if(cwndchk != 0)
				cwindow = copytext(cwindow,1,cwndchk)
			if(winget(src,null,"macro") != "inputmodemacro")
				winset(src,cwindow,"macro=\"inputmodemacro\"")
			if(IOFocus != IO)
				if(IOFocus != null)
					IOFocus.Unfocus(src)
				IOFocus = IO
				IOFocus.Focus(src)
		ClearInputFocus()
			if(IOFocus != null)
				IOFocus.Unfocus()
				IOFocus = null
				cwindow = winget(src,null,"focus")
				var/cwndchk = findtext(cwindow,".")
				if(cwndchk != 0)
					cwindow = copytext(cwindow,1,cwndchk)
				winset(src,cwindow,"macro=\"[cmacro]\"")
	verb
		KeyPress(c as text)
			set hidden = 1
			if(IOFocus != null)
				IOFocus.Input(c,src)
		KeyRelease(c as text)
			set hidden = 1
			if(IOFocus != null)
				IOFocus.Release(src)