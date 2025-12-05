quest horse_menu begin
    state start begin
		function horse_menu()
			if horse.is_mine() then
				local s = 6
				if horse.is_dead() then
					s = select("Pferd wiederbeleben", "Fortschicken", "Nichts (Fenster schließen)")
					if s == 1 then s = 0
					elseif s == 2 then s = 3
					elseif s == 3 then return
					end
				else
					s = select(
					"Füttern", "Aufsitzen", "Fortschicken", "Verfassung prüfen", 
					"Einen Namen geben", "Nichts (Fenster schließen)")
				end
				if s == 0 then
					horse.revive()
				elseif s == 1 then
					local food = horse.get_grade() + 50054 - 1
					if pc.countitem(food) > 0 then
						pc.removeitem(food, 1)
						horse.feed()
					else
						say(string.format("Du benötigst für diese Aktion folgenden[ENTER]Gegenstand:"), item_name(food))
					end
				elseif s == 2 then
					horse.ride()
				elseif s == 3 then
					horse.unsummon()
				elseif s == 4 then
					say_title("Informationen über Pferde")
					say(string.format("Derzeitige Stärke des Pferdes:"), horse.get_health_pct())
					say(string.format("Derzeitige Ausdauer des Pferdes:"), horse.get_stamina_pct())
					say("")
				end
			end
		end
		when 20030.click begin horse_menu.horse_menu() end
		when 20101.click begin horse_menu.horse_menu() end
		when 20102.click begin horse_menu.horse_menu() end
		when 20103.click begin horse_menu.horse_menu() end
		when 20104.click begin horse_menu.horse_menu() end
		when 20105.click begin horse_menu.horse_menu() end
		when 20106.click begin horse_menu.horse_menu() end
		when 20107.click begin horse_menu.horse_menu() end
		when 20108.click begin horse_menu.horse_menu() end
		when 20109.click begin horse_menu.horse_menu() end
    end
end
