quest change_guild_master_item begin
	state start begin
		function change_master( name , level_limit , time_resign_limit , time_be_other_leader , time_be_other_member , iscacheitem )
			local ret = guild.change_master_with_limit( name , level_limit , time_resign_limit , time_be_other_leader , time_be_other_member, iscacheitem)
			local result = false
			if ret == 0 then
				say("Du hast einen flaschen Namen eingegeben.")
			elseif ret == 1 then
				say("Nur Gildenleader können den Ring benutzen.")
			elseif ret == 2 then
				say("Der Gildenmember wurde nicht gefunden.")
			elseif ret == 3 then
				say("Du hast erfolgreich den Leaderposten abgegeben.")
				result = true
			elseif ret == 4 then
				say("Du bist in keiner Gilde.")
			elseif ret == 5 then
				say("Der Charakter, an den der Leaderpostern übergeben")
				say("werden soll ist nicht online.")
			elseif ret == 6 then
				say("Der Charakter, an den der Leaderpostern übergeben")
				say("werden soll hat ein zu niedriges Level.")
			elseif ret == 7 then
				say("Der Charakter, an den der Leaderpostern übergeben")
				say("werden soll hatte bereits eine Gilde.")
			end
			return result
		end
		when 71099.use begin
			say_title("Ring der Nachfolge")
			if pc.is_guild_master() == false then
				say("Nur Gildenleader können den Ring benutzen.")
				return
			end
			say("Gib bitte den Namen des neuen Gildenleaders.")
			say("ein.")
			local s = input()
			say_title("Ring der Nachfolge")
			if s == pc.name then
				say("Du kannst nicht deinen Namen eingeben.")
				return
			elseif s == "" then
				say("Gib bitte einen Namen ein.")
				return
			end
			if not pc.is_near_vid( find_pc_by_name( s ) , 10 ) then
				say("Der andere Charakter muss in deiner")
				say("nähe sein.")
				return
			end
			if change_guild_master_item.change_master( s , 40 , 0 , 0 , 0 ,true) == true then
				pc.remove_item(71099)
			elseif ret == 5 then
				say("error: 1")
				say("Bitte an die Administration wenden.")
			elseif ret == 6 then
				say("Der Charakter, an den der Leaderpostern übergeben")
				say("werden soll hat ein zu niedriges Level.")
			else
				say("error: 2")
				say("Bitte die Zahl:")
				say(ret)
				say("An die Administration melden.")				
			end
		end
	end
end

