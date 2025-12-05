quest guild_war_join begin
    state start begin
		when letter begin
			local e = guild.get_any_war()
			if e != 0 and pc.get_war_map() == 0 then
				setskin(NOWINDOW)
				send_letter("Gildenkrieg beitreten")
			end
		end
		when button begin
			local e = guild.get_any_war()
			say_title("Gildenkrieg")
			if e == 0 then				
				say("Der Gildenkrieg ist bereits beendet.")
			else
				say("Möchtest du den Gildenkrieg beitreten?")
				local s = select("Beitreten", "Abbrechen")
				if s == 1 then
					guild.war_enter(e)
				else
					setskin(NOWINDOW)
					makequestbutton("Gildenkrieg beitreten")
				end
			end
		end
    end
end

