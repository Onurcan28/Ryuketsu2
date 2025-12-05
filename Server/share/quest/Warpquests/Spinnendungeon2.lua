quest Spinnendungeon2 begin
	state start begin
		when login or levelup with pc.level >0 begin
			set_state(to_spider_2floor)
		end
	end		
	state to_spider_2floor begin
		when 20089.chat."Zurück in die 1. Ebene" begin
			say_title("Pung-Ho:")
			say("Möchtest du wirklich wieder zurück in die 1.[ENTER]Ebene?")
			local a= select("Ja","Nein")
			if 1==a then
				say_title("Pung-Ho:")
				say("Eine weise Entscheidung.[ENTER]Hier oben ist es viel zu gefährlich, um noch[ENTER]länger zu bleiben. Geh und versorge erst einmal[ENTER]deine Wunden.")
				wait()
				pc.warp(91700, 525300)
				return
			end
			say_title("Pung-Ho:")
			say("Ganz so wie du willst...[ENTER]Gib auf dich Acht![ENTER]Hier oben ist es sehr gefährlich.")
		end
	end
end
