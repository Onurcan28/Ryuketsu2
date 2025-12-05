quest reset_scroll begin
	state start begin
		when 71002.use begin
			say_title("Status zurücksetzen")
			say("Diese Schriftrolle ermöglicht es dir, all deine[ENTER]bisherigen Status-Steigerungen rückgängig zu[ENTER]machen. Dein ganzer Status ist davon betroffen:[ENTER]VIT, INT, STR und DEX werden auf 1 zurückgesetzt.[ENTER]Die dadurch freigewordenen Punkte kannst du nach[ENTER]Belieben neu verteilen.[ENTER][ENTER]Willst du die Rolle jetzt benutzen?")
			local c = select("Ja", "Nein")
			if 2 == c then
				return
			end
			pc.remove_item(71002)
			pc.reset_point()
		end
		when 71003.use begin
			say_title("Fertigkeit zurücksetzen")
			say("Eine Fertigkeit deiner Wahl wird auf Null[ENTER]zurückgesetzt. Du erhältst alle darauf[ENTER]ausgegebenen Fertigkeitspunkte zurück, außer[ENTER]denen, die durch Bücher gewonnen wurden. Das[ENTER]bedeutet, dass du maximal 17 Fertigkeitspunkte[ENTER]zurückbekommen kannst. Die zurückgewonnenen[ENTER]Punkte kannst du nach Belieben neu auf deine[ENTER]Fertigkeiten verteilen.")
			local s = select("Fortfahren", "Abbrechen")
			if 2 == s then return end
			local result = BuildSkillList(pc.get_job(), pc.get_skill_group())
			local vnum_list = result[1]
			local name_list = result[2]
			if table.getn(vnum_list) < 2 then
				say("Du hast keine Fertigkeit, die du zurücksetzen[ENTER]könntest.")
				return
			end 
			say("Bitte wähle die Fertigkeit aus, die du[ENTER]zurücksetzen möchtest.")
			local i = select_table(name_list)
			if table.getn(name_list) == i then
				return
			end
			local name = name_list[i]
			local vnum = vnum_list[i]
			pc.remove_item(71003)
			pc.clear_one_skill(vnum)
		end
	end
end
