quest acce begin
	state start begin
		when 60003.chat."Was ist ein Schulterband?" begin
			say_title(""..mob_name(60003)..":")
			say("Mit dem Schulterband hast du zwei Möglichkeiten:[ENTER]Kombination und Aufnahme.[ENTER][ENTER]Die Kombination kannst du nur zwischen Bändern[ENTER]desselben Grades durchführen. Zwei miteinander[ENTER]kombinierte Bänder können ein hochwertigeres Band[ENTER]ergeben.[ENTER][ENTER]Bei der Aufnahme werden Boni von einer Waffe oder[ENTER]Rüstung zu verschiedenen Prozentsätzen auf das[ENTER]Schulterband übertragen.[ENTER][ENTER]Die Aufnahmerate (%) ist dabei abhängig vom Grad[ENTER]des Bandes. Bei der Aufnahme von Boni wird die[ENTER]gewählte Waffe oder Rüstung zerstört.")
		end

		when 60003.chat."Kombination" begin
			say_title(""..mob_name(60003)..":")
			say("Möchtest du zwei Bänder kombinieren?")
			local confirm = select("Ja", "Nein")
			if confirm == 2 then
				return
			end

			setskin(NOWINDOW)
			pc.acce_open_combine()
		end

		when 60003.chat."Aufnahme von Boni" begin
			say_title(""..mob_name(60003)..":")
			say("Möchtest du Boni von deiner Waffe oder Rüstung[ENTER]aufnehmen?")
			local confirm = select("Ja", "Nein")
			if confirm == 2 then
				return
			end
			
			setskin(NOWINDOW)
			pc.acce_open_absorb()
		end
	end
end