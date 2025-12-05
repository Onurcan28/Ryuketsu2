quest training_grandmaster_skill begin
    state start begin
		when 50513.use begin
			if pc.get_skill_group() == 0 then
				say_title("Fertigkeitstraining der Groﬂmeister")
				say("Du bist bis jetzt noch keiner Lehre beigetreten.")
				return
			end

			if get_time() < pc.getqf("next_time") then
				if pc.is_skill_book_no_delay() then
					say_title("Fertigkeitstraining der Groﬂmeister")
					say("Da du die Exorzismus-Schriftrolle gelesen hast,[ENTER]kannst du weiter trainieren, ohne eine Pause[ENTER]einlegen zu m¸ssen.")
					wait()
				else
					say_title("Fertigkeitstraining der Groﬂmeister")
					say("Wenn du dein Training absolviert hast, musst du[ENTER]einen halben Tag Pause machen. Versuche es sp‰ter[ENTER]noch einmal oder benutze eine[ENTER]Exorzismus-Schriftrolle.")
					return
				end
			end

			local result = training_grandmaster_skill.BuildGrandMasterSkillList(pc.get_job(), pc.get_skill_group())

			local vnum_list = result[1]
			local name_list = result[2]

			if table.getn(vnum_list) == 0 then
				say_title("Fertigkeitstraining der Groﬂmeister")
				say("Du hast noch keine Fertigkeit so weit erlernt,[ENTER]dass du den Status des Groﬂmeisters erlangen[ENTER]kannst.")
				return
			end
			say_title("Fertigkeitstraining der Groﬂmeister")
			say("Bitte w‰hle eine Fertigkeit aus, in der du den[ENTER]Status des Groﬂmeisters erlangen mˆchtest.")

			local menu_list = {}
			table.foreach(name_list, function(i, name) table.insert(menu_list, name) end)
			table.insert(menu_list, "Abbrechen") 

			local s=select_table(menu_list)
			
			if table.getn(menu_list) == s then
				return
			end

			local skill_name=name_list[s]
			local skill_vnum=vnum_list[s]
			local skill_level = pc.get_skill_level(skill_vnum)
			local cur_alignment = pc.get_real_alignment()
			local need_alignment = 1000+500*(skill_level-30)

			test_chat(string.format("Aktuelle Rangpunkte: %s", cur_alignment.." Erforderliche Rangpunkte: "..need_alignment))

			local title=string.format("%s Groﬂmeister Fertigkeitstraining", skill_name, skill_level-30+1)

			say_title("Fertigkeitstraining der Groﬂmeister")
			say("Das Groﬂmeistertraining verbraucht Rangpunkte.[ENTER]Es kann also sein, dass du in den negativen[ENTER]Punktebereich f‰llst.")

			if cur_alignment<-19000+need_alignment then
				say_reward("Es stehen nicht gen¸gend Rangpunkte f¸r das[ENTER]Training zur Verf¸gung.")
				return
			end

			if cur_alignment<0 then
				say_reward(string.format("Erforderliche Rangpunkte: %s -> %s", need_alignment, need_alignment*2))
				say_reward("Deine Rangpunkte sind im negativen Bereich.[ENTER]Das bedeutet, dass du zum Steigern einer[ENTER]Groﬂmeister-Fertigkeit doppelt so viele[ENTER]Rangpunkte ausgeben musst, wie jemand, dessen[ENTER]Punkte sich im positiven Bereich befinden.")
				need_alignment=need_alignment*2
			elseif cur_alignment<need_alignment then
				say_reward(string.format("Erforderliche Rangpunkte: %s", need_alignment))
				say_reward("Wenn du jetzt trainierst, werden deine Rangpunkte[ENTER]in den negativen Bereich fallen.")
			else
				say_reward(string.format("Erforderliche Rangpunkte: %s", need_alignment))
			end
				
			local s= select("Ja", "Abbrechen")	
			
			if s==2 then
				return
			end


			if cur_alignment>=0 and cur_alignment<need_alignment then
				say_title(title)
				say_reward("Best‰tigen!")
				say("Wenn du jetzt eine Groﬂmeisterfertigkeit[ENTER]steigerst, kˆnnten deine Rangpunkte in den[ENTER]negativen Bereich fallen, da du im Moment nur[ENTER]wenige besitzt. Willst du die Fertigkeit wirklich[ENTER]steigern?")
				say_reward("trainieren")
				say("Willst du nicht trainieren, dr¸cke einfach[ENTER]'ENTER'.")
				local s=input()
				s = string.gsub(s, "(%a*)%s*", "%1")
				s = string.lower(string.gsub(s, "(%a*)%s*", "%1"))

				local t = string.gsub("trainieren", "(%a*)%s*", "%1")
				t = string.lower(string.gsub("trainieren", "(%a*)%s*", "%1"))
				
				if s!=t then
					return
				end
			end

			if get_time() < pc.getqf("next_time") then
				if pc.is_skill_book_no_delay() then
					pc.remove_skill_book_no_delay()
				else
					say_title("Fertigkeitstraining der Groﬂmeister")
					return
				end
			end

			pc.setqf("next_time", get_time()+time_hour_to_sec(number(8, 12)))


			if need_alignment>0 then
				if pc.count_item(50513) > 0 then
					if pc.learn_grand_master_skill(skill_vnum) then
						pc.change_alignment(-need_alignment)
				
						say_title(title)
						say_reward("Erfolgreich!")

						if 40 == pc.get_skill_level(skill_vnum) then
							say("Herzlichen Gl¸ckwunsch! Du hast es geschafft.")
							say(string.format("%s ist nun auf Perfekter Meister.", skill_name))
							say("Dies bedeutet, dass du diese Fertigkeit nun[ENTER]perfekt beherrschst und nicht mehr weiter[ENTER]verbessern kannst.")
						else
							say("Herzlichen Gl¸ckwunsch! Du hast es geschafft.[ENTER]Durch das Fertigkeitstraining der Groﬂmeister[ENTER]stieg")
							say(string.format(" %s auf Level %s.", skill_name, skill_level-30+1+1))
						end
						say_reward("Du hast dein Level erfolgreich gesteigert!")
						say_reward(string.format("Du hast %s Rangpunkte verbraucht.", need_alignment))
					else
						say_title(title)
						say_reward("Fehlgeschlagen!")
						say("Du hast deine Fertigkeiten nicht verbessern[ENTER]kˆnnen.")
						say_reward("Du hast einige Rangpunkte verloren und den[ENTER]Seelenstein verbraucht.")
						pc.change_alignment(-number(need_alignment/3, need_alignment/2))
					end
					pc.remove_item(50513)
				else
					char_log(0, "HACK 50513", pc.getname())
				end
			end
		end

		function BuildGrandMasterSkillList(job, group)
			GRAND_MASTER_SKILL_LEVEL = 30
			PERFECT_MASTER_SKILL_LEVEL = 40

			local skill_list = special.active_skill_list[job+1][group]
			local ret_vnum_list = {}
			local ret_name_list = {}

			table.foreach(skill_list, 
			function(i, skill_vnum) 
			local skill_level = pc.get_skill_level(skill_vnum)

			if skill_level >= GRAND_MASTER_SKILL_LEVEL and skill_level < PERFECT_MASTER_SKILL_LEVEL then
				table.insert(ret_vnum_list, skill_vnum)
				local name=locale.GM_SKILL_NAME_DICT[skill_vnum]
				
				if name == nil then name=skill_vnum end
					table.insert(ret_name_list, name)
				end
			end)
			return {ret_vnum_list, ret_name_list}
		end
    end
end
