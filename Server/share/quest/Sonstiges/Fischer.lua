quest fisher begin
	state start begin
		when 9009.chat."Laden öffnen" begin
			npc.open_shop()
			setskin(NOWINDOW)
		end
		when 9009.chat."Angelrute verbessern" begin
			say_title("Fischer:")
			say("Du bist also an den Geheimnissen zur Verbesserung[ENTER]deiner Angelrute interessiert? Eigentlich gibt es[ENTER]da nicht wirklich ein Geheimnis. Wenn du Zeit mit[ENTER]Fischen verbringst, sammelt deine Angelrute[ENTER]Punkte. Sobald diese ihren Höchststand erreicht[ENTER]haben, bringst du die Angel zu mir. Dann kann ich[ENTER]versuchen, sie für dich zu verbessern.[ENTER]Gut. Wähle also nun die Angelrute, die du zu[ENTER]verbessern wünschst und gib sie mir.")   
		end
		when 9009.take with item.vnum<27400 or item.vnum>27590 begin
			say_title("Fischer:")
			say("Was soll ich denn damit? Ich kann nur Angelruten[ENTER]verbessern!")
		end
		when 9009.take with item.vnum == 27590 begin
			say_title("Fischer:")
			say("Tut mir leid. Diese Angelrute kann nicht weiter[ENTER]verbessert werden.")
		end
		when 9009.take with item.vnum >= 27400 and item.vnum < 27590 and item.get_socket(0)!= item.get_value(2) begin
			say_title("Fischer:")
			say("Diese Angelrute hat noch nicht genug Punkte[ENTER]gesammelt. Ich kann sie jetzt noch nicht[ENTER]verbessern. Komm wieder, wenn deine Angel die[ENTER]höchstmögliche Punktzahl erreicht hat!")
		end
		when 9009.take with item.vnum >= 27400 and item.vnum < 27590 and item.get_socket(0) == item.get_value(2) begin
			say_title("Fischer:")
			say("Du willst diese Angelrute verbessern?[ENTER]Lass mich mal sehen...")
			say(string.format("Die Stufe deiner Angel beträgt momentan %s.", item.get_value(0) / 10))
			say("Hmm, ich glaub nicht, dass ich gut genug bin")
			say("um diese Angel zu verbessern. Soll ich's probieren?")
			say(string.format("Es kann sein, dass das Level deiner Angel Level %d von 100", 100 - item.get_value(3)))
			say("verringert wird.")
			say("Soll ich es trotzdem probieren?")
			local s = select("Ja", "Nein")
			if s == 1 then
				local f = __fish_real_refine_rod(item.get_cell())
				say_title("Fischer:")
				if f == 2 then					
					say("Leider habe ich es nicht geschafft deine")
					say("Angel zu verbessern, aber sie wurde nicht zerstört.")                              
					say("Du wirst sie so zurück bekommen wie sie war.")
					say("")
				elseif f == 1 then
					say("Wunderbar, es hat funktioniert. Hier ist die[ENTER]verbesserte Angelrute!")
				else
					say("Der Versuch hat leider nicht funktioniert. Es tut[ENTER]mir leid, denn nun haben sich die Punkte deiner[ENTER]Angelrute reduziert.")
				end
			else
				say_title("Fischer:")
				say("Wie du willst. Komm später noch einmal wieder!")
			end
		end
	end
end
