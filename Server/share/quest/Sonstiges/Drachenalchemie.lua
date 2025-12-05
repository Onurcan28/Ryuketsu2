quest dragon_soul begin
	state start begin
		when levelup or letter with pc.level >= 30 begin
			send_letter("Ankunft der Drachensteinsplitter")
			local v = find_npc_by_vnum(20001)
			
			if 0 != v then
				target.vid("__TARGET__", v, mob_name(20001))
			end
		end
		when info or button begin
			say("Der Alchemist mit dem fundiertesten Wissen über[ENTER]Mineralien im ganzen Reich sucht nach dir. Geh[ENTER]schnell zu ihm!")
		end

		when 20001.chat."Drachensteinsplitter?!" with pc.level >= 30 begin
			target.delete("__TARGET__")

			say_title(mob_name(20001))
			say("Ah, da bist du ja! Ich habe etwas Erstaunliches[ENTER]entdeckt: das Fragment eines Drachensteins! Ein[ENTER]Drachenstein ist ein äußerst seltener und[ENTER]wertvoller Kristall mit großer Macht. Es heißt,[ENTER]das sei die Seele eines Drachen. Unfassbar schön![ENTER]Ich verleihe dir die Macht des Drachenauges,[ENTER]damit du die Splitter aufspüren kannst.[ENTER]Bringe mir insgesamt zehn Drachensteinsplitter.[ENTER]Diese kann ich zu einem ganzen Stein[ENTER]transmutieren.")
			set_state(state_learning)
		end
	end
	state state_learning begin
		when letter begin
			send_letter("Drachensteinsplitter sammeln")
		end
		when info or button begin
			say("Bringe dem Alchemisten 10 Drachensteinsplitter.")
		end
		when kill begin
			if npc.is_pc() then
				return
			end
			
			if pc.count_item(30270) < 10 then
				local drop = number(1, 100)
				if drop <= 10 then
					game.drop_item_with_ownership(30270, 1, 300)
				end
			end
		end
		when 20001.chat."Drachensteinsplitter sammeln" begin
			say_title(mob_name(20001))
			if pc.count_item(30270) >= 10 then
				say("Ah, du hast zehn Drachensteinsplitter. Bitte[ENTER]gedulde dich einen Moment ...[ENTER]Erstaunlich! Bei der Transmutation ist ein Cor[ENTER]Draconis entstanden - ein kristallenes[ENTER]Drachenherz, das den Drachenstein schützend[ENTER]umhüllt. Wenn du es aufbrichst, wandert der[ENTER]Drachenstein darin direkt in das Inventar der[ENTER]Drachensteinalchemie.[ENTER]Um Drachensteinsplitter zu finden und zu[ENTER]transmutieren, brauchst du die Macht des[ENTER]Drachenauges. Einmal täglich kann ich sie dir[ENTER]verleihen.[ENTER]Den ersten Drachenstein habe ich dir hergestellt.[ENTER]Die restlichen %d schaffst nun du alleine!")
				pc.remove_item(30270, 10)
				ds.give_qualification()
				char_log(pc.get_player_id(), 'DS_QUALIFICATION', 'SUCCESS')
				pc.give_item2(50255)
				local today = math.floor(get_global_time() / 86400)
				pc.setf("dragon_soul", "eye_timestamp", today)
				pc.setf("dragon_soul", "eye_left", 29)
				set_state(state_farming)
			else
				say("He, verschwende keine Zeit! Geh lieber und suche[ENTER]Drachensteinsplitter!")
			end
		end
	end
	state state_farming begin
		when letter begin
			send_letter("Macht des Drachenauges")
		end
		when info or button begin
			say_title("Macht des Drachenauges")
			say(string.format("Verbleibende Macht des Drachenauges: %d", pc.getf("dragon_soul", "eye_left")))
		end
		when kill begin
			if npc.is_pc() then
				return
			end
			
			local drop = number(1, 100)
			if drop <= 10 then
				local eye_left = pc.getf("dragon_soul", "eye_left")
				local haved_gemstone_number = pc.count_item(30270)
				
				if eye_left > haved_gemstone_number / 10 then
					game.drop_item_with_ownership(30270, 1, 300)
				end
			end
		end
		when 30270.pick begin
			local eye_left = pc.getf("dragon_soul", "eye_left")
			if eye_left <= 0 then
				return
			end

			if pc.count_item(30270) >= 10 then
				pc.setf("dragon_soul", "eye_left", eye_left - 1)
				pc.remove_item(30270, 10)
				pc.give_item2(50255)
				if 1 == eye_left then
					set_state(state_closed_season)
				end
			end
		end
		when 20001.chat."Drachenstein-Veredelung" with ds.is_qualified() != 0 begin
			say_title(mob_name(20001))
			say("Du möchtest einen Drachenstein veredeln? Nur zu.[ENTER]Vorher solltest du jedoch wissen, dass dieser[ENTER]Prozess auch fehlschlagen kann.[ENTER]Ich habe gehört, dass die sogenannten[ENTER]Drachenbohnen, die man hinter der drehenden Münze[ENTER]findet, die Chancen verbessert.")
			ds.open_refine_window()
		end

		when 20001.chat."Laden öffnen" with ds.is_qualified() begin
			setskin(NOWINDOW)
			npc.open_shop(131)
		end
		when 20001.chat."Gib mir die Macht des Drachenauges" begin
			say_title(mob_name(20001))
			local today = math.floor(get_global_time() / 86400)
			if today == pc.getf("dragon_soul", "eye_timestamp") then
				say("Hallo! Du hast die Macht des Drachenauges heute[ENTER]bereits erhalten. Der Vorgang schwächt mich zu[ENTER]sehr, ich kann dir nur einmal pro Tag helfen.[ENTER]Komm morgen wieder!")
			else
				say("Hallo! Ich wette, du bist wegen der Macht des[ENTER]Drachenauges hier. Richtig? Also gut, hier hast[ENTER]du sie. Viel Glück bei der Suche! Ich hoffe, du[ENTER]findest genügend Splitter für zehn Drachensteine!")
				pc.setf("dragon_soul", "eye_timestamp", today)
				pc.setf("dragon_soul", "eye_left", 30)
			end	
		end
	end
	state state_closed_season begin
		when letter begin
			send_letter("Fehlende Macht des Drachenauges")
		end
		when info or button begin
			say("Die Macht des Drachenauges hat dich verlassen.")
			local today = math.floor(get_global_time() / 86400)
			if today == pc.getf("dragon_soul", "eye_timestamp") then
				say("Geh morgen zum Alchemisten zurück, um dir erneut[ENTER]die Macht des Drachenauges abzuholen!")
			else
				say("Geh zum Alchemisten, um dir die Macht des[ENTER]Drachenauges abzuholen!")
			end
		end
		
		when 20001.chat."Macht des Drachenauges" begin
			say_title(mob_name(20001))
			local today = math.floor(get_global_time() / 86400)
			if today == pc.getf("dragon_soul", "eye_timestamp") then
				say("Hallo! Du hast die Macht des Drachenauges heute[ENTER]bereits erhalten. Der Vorgang schwächt mich zu[ENTER]sehr, ich kann dir nur einmal pro Tag helfen.[ENTER]Komm morgen wieder!")
			else
				say("Hallo! Ich wette, du bist wegen der Macht des[ENTER]Drachenauges hier. Richtig? Also gut, hier hast[ENTER]du sie. Viel Glück bei der Suche! Ich hoffe, du[ENTER]findest genügend Splitter für zehn Drachensteine!")
				pc.setf("dragon_soul", "eye_timestamp", today)
				pc.setf("dragon_soul", "eye_left", 30)
				set_state(state_farming)
			end
		end
	end
	-- deprecated states. so, jump to new state.
	state state_1 begin
		when login begin
			set_state(state_learning)
		end
	end
	state state_2 begin
		when login begin
			set_state(state_learning)
		end
	end
	state state_3 begin
		when login begin
			set_state(state_closed_season)
		end
	end
end

