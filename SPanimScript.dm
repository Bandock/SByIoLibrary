SPanimScript
	var
		list
			States = new()
	New(file)
		var/data = file2text(file)
		var/cpos = 1
		var/nlpos = findtext(data,"\n")
		var/varname = ""
		var/AnimState/AS
		var/AnimStage/Stage
		var/statename = ""
		while(1)
			var/statement = copytext(data,cpos,nlpos)
			var/tpos = findtext(data,"	",cpos, nlpos)
			if(tpos == 0)
				if(statename != "")
					States[statename] = AS
				statename = copytext(data,cpos,nlpos)
				AS = new()
				Stage = new()
			else
				cpos = tpos + 1
				var/spos = findtext(data," ",cpos,nlpos)
				if(spos != 0)
					var/token = copytext(data,cpos,spos)
					varname = token
					if(lowertext(varname) == "alpha" || \
						lowertext(varname) == "loop" || \
						lowertext(varname) == "time")
						cpos = spos + 1
						token = copytext(data,cpos,nlpos)
						var/value = text2num(token)
						if(varname == "alpha")
							Stage.SetAlpha(value)
						else if(varname == "loop")
							Stage.SetLoop(value)
						else if(varname == "time")
							Stage.SetTime(value)
				else
					var/token = copytext(data,cpos,nlpos)
					if(token == "addstage")
						AS.AddStage(Stage)
						world.log << "Stage added."
						Stage = new()
			if(nlpos != 0)
				cpos = nlpos + 1
				nlpos = findtext(data,"\n",cpos)
			else
				break
		if(statename != "")
			States[statename] = AS
	proc
		GetState(statename)
			if(States[statename] != null)
				return States[statename]
			else
				world.log << "Error:  There is no state by the name of [statename]."
				return null