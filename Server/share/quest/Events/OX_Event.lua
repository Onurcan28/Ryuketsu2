quest oxevent_manager begin
	state start begin
		when 20011.chat."OX-Wettbewerb" begin
			say_title("Uriel:")
			say("Hey - du da! Ja, genau du.")
			say("Du schaust recht intelligent aus. Es gibt einen")
			say("Wettbewerb, der heißt OX-Wettbewerb. Dort wird") 
			say("dein Wissen abgefragt. Wenn du gewinnst,")
			say("bekommst du eine tolle Belohnung.")

			if game.get_event_flag("oxevent_status") == 0 then
				wait()
				say_title("Uriel:")
				say("Wenn der Wettbewerb los geht, kann ich dich")
				say("daran teilnehmen lassen, aber du kannst auch")
				say("einfach nur zuschauen.")
				say("Der Startzeitpunkt ist noch nicht festgelegt.")
				say("Ich gebe dir Bescheid, also halte dich bereit.")
			elseif game.get_event_flag("oxevent_status") == 1 then
				wait()
				say_title("Uriel:")
				say("Möchtest du auch dabei sein?")

				local s = select("Ja", "Nein", "Zuschauen")

				if s == 1 then
					say_title("Uriel:")
					say("Okey, du wirst zum Wettbewerb telepotiert.")

					wait()

					pc.warp(896500, 24600)
				elseif s == 3 then
					say_title("Uriel:")
					say("Du willst also nur zuschauen?")
					say("Okey, du wirst zum OX-Wettbewerb telepotiert.")

					wait()

					pc.warp(896300, 28900)
				end
			elseif game.get_event_flag("oxevent_status") == 2 then
				
				say_title("Uriel:")
				say("Du kannst nicht mehr teilnehmen!")
				say("Nur noch den restlichen Verlauf des Events zugucken.")

				local s = select("Zuschauen", "Schließen")
				if s == 1 then
					say_title("Uriel:")
					say("Du wirst zum Wettbewerb telepotiert.")

					wait()

					pc.warp(896300, 28900)
				end
			end
		end

		when 20358.chat."OX-Wettbewerb" with pc.is_gm() begin

			local stat = oxevent.get_status()

			if stat == 0 then
				
					say_title("Namenlose Blumen:")
					say("Möchtest du, das OX-Wettbewerb starten?")


				local s = select("Ja", "Nein")

				if s == 1 then
					local v = oxevent.open()

					if v == 0 then
						say_title("Namenlose Blumen:")
						say("Der OX-Wettbewerb ist schon aktiviert.")
					elseif v == 1 then
						say_title("Namenlose Blumen:")
						say("Der OX-Wettbewerb wurde gestartet.")

						notice_all("Der OX-Wettbewerb hat gerade angefangen!")
					else
						say_title("Namenlose Blumen:")
						say("Der OX-Wettbewerb könnte nicht ausgeführt werden.")
					end
				end
			elseif stat == 1 then
					say_title("Namenlose Blumen:")
					say("Es ist/sind "..oxevent.get_attender().." Spieler hier.")
					say("Willst du den Zugang wirklich schließen?")

					local s = select("Ja", "Nein")

					if s == 1 then
						oxevent.close()

						say_title("Namenlose Blumen:")
						say("Der Zugang wurde soeben geschlossen!")
					end
			elseif stat == 2 then

					say_title("Namenlose Blumen:")
					say("Was möchtest du machen?")

					local s = select("Frage stellen", "Alle Spieler belohnen", "Beenden", "Schließen")

					if s == 1 then
						local v = oxevent.quiz(1, 30)

						if v == 1 then
							say_title("Namenlose Blumen:")
							say("Das OX-Wettbewerb läuft zurzeit noch nicht!")
						elseif v == 0 then
							say_title("Namenlose Blumen:")
							say("Die Frage wurde erfolgreich abgesendet!")
						else
							say_title("Namenlose Blumen:")
							say("Es wird schon eine Frage gestellt!")
						end
					elseif s == 2 then
						say_title("Namenlose Blumen:")
						say("Bitte gib die Itemnummer in das Feld ein.")

						local item_vnum = input()

						say_title("Namenlose Blumen:")
						say("Bitte gib die Itemanzahl in das Feld ein.")

						local item_count = input()

						oxevent.give_item(item_vnum, item_count)

						say_title("Namenlose Blumen:")
						say("Du hast "..oxevent.get_attender().." Spieler die Belohnung gegeben!")
					elseif s == 3 then
						oxevent.end_event()

						notice_all("Der OX-Wettbewerb hat gerade sein Ende gefunden!")

						say_title("Namenlose Blumen:")
						say("Du hast den OX-Wettbewerb beendet!")
					end
			elseif stat == 3 then
					say_title("Namenlose Blumen:")
					say("Bitte warte einen Augenblick.")
				else
					say("Ein Fehler ist aufgetreten!")
				end
			end

		when 20358.chat."Teaminsel" with pc.is_gm() begin
			say_title("Namenlose Blumen:")
			say("Möchtest du zur Teaminsel teleportiert werden?")

			local s = select("Ja", "Nein")

			if s == 1 then
				say_title("Namenlose Blumen:")
				say("Du wirst zur Teaminsel telepotiert.")

				wait()

				pc.warp(45000, 65000)
			end
		end
	end
end

