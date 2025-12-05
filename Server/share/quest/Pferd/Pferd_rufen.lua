quest horse_summon begin
	state start begin
		when 20349.chat."Neues Pferdebild" with horse.get_grade()==1 and pc.countitem("50051")<1 begin
			say_title("Stallbursche:")
			say("Du hast das Pferdebild verloren! Gegen eine[ENTER]Gebühr von 400.000 Yang gebe ich dir ein neues.")
			local b=select("Kaufen", "Nicht Kaufen")
			if 1==b then
				say_title("Stallbursche:")
				if pc.money>=400000 then
					pc.changemoney(-400000)
					say("Dies ist das neue Pferdebild. Verliere es nicht[ENTER]wieder.")
					pc.give_item2("50051", 1)
				else
					say("Du hast nicht genügend Yang.")
				end
			end
		end
		when 20349.chat."Neues Waffen-Pferdebuch" with horse.get_grade()==2 and pc.countitem("50052")<1 begin
			say_title("Stallbursche:")
			say("Du hast das Waffen-Pferdebuch verloren![ENTER]Gegen eine Gebühr von 500.000 Yang gebe ich dir[ENTER]ein neues.")
			local b=select("Kaufen", "Nicht Kaufen")
			if 1==b then
				say_title("Stallbursche:")
				if pc.money>=500000 then
					pc.changemoney(-500000)
					say("Dies ist das neu ausgegebene Waffen-Pferdebuch.[ENTER]Verliere es nicht wieder.")
					pc.give_item2("50052", 1)
				else
					say("Du hast nicht genügend Yang.")
				end
			end
		end
		when 20349.chat."Neues Militär-Pferdebuch" with horse.get_grade()==3 and pc.countitem("50053")<1 begin
			say_title("Stallbursche:")
			say("Du hast das Militär-Pferdebuch verloren![ENTER]Die Gebühr für die Neuausgabe beträgt 500.000[ENTER]Yang.")
			local b=select("Kaufen", "Nicht Kaufen")
			if 1==b then
				say_title("Stallbursche:")
				if pc.money>=500000 then
					pc.changemoney(-500000)
					say("Dies ist das neu ausgegebene Militär-Pferdebuch.[ENTER]Verliere es nicht wieder.")
					pc.give_item2("50053", 1)
				else
					say("Du hast nicht genügend Yang.")
				end
			end
		end
		when 50051.use with horse.get_level()==0 begin
			say("Du besitzt momentan kein Pferd.")
		end
		when 50051.use with horse.get_level() >= 1 and horse.get_level() < 11 begin
			horse.summon()
		end
		when 50052.use with horse.get_level() >= 11 and horse.get_level() < 21 begin
			horse.summon()
		end
		when 50053.use with horse.get_level()==21 begin
			horse.summon()
		end
	end	
end
