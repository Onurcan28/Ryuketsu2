quest energy_system begin
	state start begin
		when 20001.chat."Eine neue Technik!" begin
			say_title(mob_name(20001)) 
			say("Ich habe es geschafft![ENTER]Endlich konnte ich eine vollkommen neue Technik[ENTER]entwickeln.[ENTER]Ich habe es möglich gemacht, Gegenstände[ENTER]weiterzuverarbeiten und pure Energie aus ihnen zu[ENTER]ziehen. Absolut brillant!")
			wait()
			say_title(mob_name(20001)) 
			say("Zerstört man einen Gegenstand mithilfe meiner[ENTER]Technik, erhält man Energiesplitter. Fügt man 30[ENTER]dieser Splitter zusammen, erhält man einen[ENTER]machtvollen Energiekristall! Reine, ungefilterte[ENTER]Energie, gebündelt in einem Edelstein. Diese[ENTER]Kraft fließt in deine gesamte Ausrüstung.[ENTER]Hast du Interesse daran?")
			wait()
			say_title(mob_name(20001)) 
			say("Bring Ausrüstungsgegenstände wie Waffen, Schmuck[ENTER]und Kleidung, die du auf deiner Jagd findest, zu[ENTER]mir. Ich werde sie zu Energiesplittern[ENTER]verarbeiten.[ENTER]Zukunft und Hoffnung unseres Reiches liegen in[ENTER]dieser Technik. Wir werden unbesiegbar!")
			setstate(can_make)
		end
	end

	state can_make begin
		function setting () 
			return
			{
				["prob_acc_table"] = 
				{
					["35to50"] = {30,55,70,80,90,95,97,98,99,100},
					["51to70"] = {20,40,60,75,85,91,96,98,99,100},
					["upto70"] = {10,25,45,65,80,88,94,97,99,100}
				},
				["item_num_table"] ={0,5,10,12,15,20,25,30,35,40},
				["energy_stone"] = 51001,
				["charging_stone"] = 51002
			}
		end	
		function getItemNum ( str, r )
			local setting = energy_system.setting()
			for i = 1, 10 do
				if r < setting.prob_acc_table[str][i] then
					return setting.item_num_table[i]
				end
			end
			return 0
		end

		when 20001.chat."Energiesplitter extrahieren" begin
			say_title(mob_name(20001)) 
			say("Hat es funktioniert? Hast du Energiesplitter[ENTER]bekommen?[ENTER]Bring mir mehr Gegenstände und ich werde sie[ENTER]mithilfe der Alchemie zerbrechen.[ENTER]Meine Technik ist noch nicht ganz ausgefeilt.[ENTER]Deswegen kann ich dir nicht garantieren, wie[ENTER]viele Splitter du erhältst.")
			wait()
			say_title(mob_name(20001)) 
			say("Es gibt eine Bedingung: Sowohl dein eigener als[ENTER]auch der Level des Gegenstandes muss mindestens[ENTER]35 sein.[ENTER]Hm, schauen wir einfach mal ...")
			wait()
			if pc.get_level() < 35 then 
				say_title(mob_name(20001)) 
				say("Du bist noch nicht stark genug! Komm wieder, wenn[ENTER]du mindestens Level 35 erreichst hast.")
			else
				say_title(mob_name(20001)) 
				say("Ah, ausgezeichnet! Du bist stark und erfahren.[ENTER]Gib mir den Gegenstand, den ich verarbeiten soll.")
			end
		end

		when 20001.take begin
			if pc.get_level() < 35 then 
				say_title(mob_name(20001)) 
				say("Du bist noch nicht stark genug, um die Kraft, die[ENTER]den Energiesplittern innewohnt, zu beherrschen.[ENTER]Komm wieder, wenn du mindestens Level 35 erreicht[ENTER]hast.")
				return
			end
			local item_vnum = item.vnum
			local levelLimit = item.get_level_limit(item_vnum)
			local setting = energy_system.setting()
			
			if levelLimit == nil then
				say_title(mob_name(20001)) 
				say("Du bist noch nicht stark genug, um die Kraft, die[ENTER]den Energiesplittern innewohnt, zu beherrschen.[ENTER]Komm wieder, wenn du mindestens Level 35 erreicht[ENTER]hast.")
				wait()
			elseif item.get_type() == ITEM_WEAPON and item.get_sub_type() == WEAPON_ARROW then
				say_title (mob_name(20001)) 
				say ("Dieser Gegenstand eignet sich nicht für meine[ENTER]Technik. Bring mir etwas Anderes.")
				wait()
			elseif levelLimit < 35 then
				say_title(mob_name(20001)) 
				say("Dieser Gegenstand hat nicht genug Energie.[ENTER]Bring mir einen mit mindestens Level 35 - nur[ENTER]dann kann ich mit meiner Technik seine Kraft[ENTER]herauspressen.")
			else
				say_title(mob_name(20001)) 
				say(item_name(item_vnum))
				say("Soll ich diesen Gegenstand zerstören?")
				local s = select ("Ja!", "Nein, noch nicht!")
				if s == 1 then
					item.remove()
					local r = number(1, 100)
					local n
					if levelLimit >= 35 and levelLimit <= 50 then
						n = energy_system.getItemNum ("35to50",r)
					elseif levelLimit > 50 and levelLimit <= 70 then
						n = energy_system.getItemNum ("51to70",r)
					else
						n = energy_system.getItemNum ("upto70",r)
					end
					if (n == 0) then
						say_title(mob_name(20001)) 
						say("Ich habe versagt - leider konnte ich keinen[ENTER]Energiesplitter extrahieren. Vielleicht klappt es[ENTER]beim nächsten Versuch.")
					else
						pc.give_item2(setting.energy_stone, n)
						say_title(mob_name(20001)) 
						say(string.format("Sagenhaft! Ich konnte %d Energiesplitter finden.[ENTER]Bitte sehr.",n))
					end
				end
			end
		end

		when 20001.chat."Energiekristall herstellen" begin
			local setting = energy_system.setting()
			local need = 30
			say_title(mob_name(20001)) 
			say(string.format("Hast du deine Kraftreserven etwa schon[ENTER]aufgebraucht? Du solltest nicht so hart arbeiten[ENTER]und dein Leben leichtsinnig aufs Spiel setzen.[ENTER]Um einen Energiekristall herzustellen, benötige[ENTER]ich %d Energiesplitter.",need))
			wait()
			
			if pc.get_level() < 35 then 
				say_title(mob_name(20001)) 
				say("Du bist noch nicht stark genug! Komm wieder, wenn[ENTER]du mindestens Level 35 erreichst hast.")
				return
			end
			
			if pc.count_item(setting.energy_stone) < need then
				say_title(mob_name(20001)) 
				say(string.format("Du hast noch nicht genügend Energiesplitter.[ENTER]Daraus kann ich keinen Energiekristall herstellen.Komm wieder, wenn du mindestens %d Splitter[ENTER]gesammelt hast.",need))
				return
			else
				say_title(mob_name(20001)) 
				say(string.format("Sehr schön, du hast die benötigten %d[ENTER]Energiesplitter. Daraus kann ich einen[ENTER]Energiekristall herstellen.[ENTER]Warte bitte einen Moment. Ich werde es versuchen,[ENTER]aber ich kann dir nicht garantieren, dass es[ENTER]funktioniert.", need))
				wait()
			end
			
			local charge = 1000
			say_title(mob_name(20001)) 
			say(string.format("Alles ist bereit, um die Splitter zu einem[ENTER]Energiekristall zu verschmelzen.[ENTER]Doch von irgendetwas muss auch ich leben und[ENTER]meine Werkzeuge fallen nicht einfach so vom[ENTER]Himmel. Ich verlange einen kleinen[ENTER]Unkostenbeitrag von %d Yang. Bist du bereit, zu[ENTER]bezahlen?", charge))
			local s = select ("Selbstverständlich!","Nein, jetzt nicht.")
			if s == 2 then
				say_title(mob_name(20001)) 
				say("In Ordnung, ich werde deine Entscheidung[ENTER]respektieren.[ENTER]Komm wieder, wenn du dich anders entschlossen[ENTER]hast und doch einen Energiekristall benötigst.")
				return
			end

			if pc.get_gold() < charge then
				say_title(mob_name(20001)) 
				say("Tut mir leid, erst musst du bezahlen. Ich bin[ENTER]doch nicht die Wohlfahrt.[ENTER]So läuft das Geschäft - gib mir das Geld, dann[ENTER]werde ich mich an die Arbeit machen.")
				return
			end
			
			if pc.count_item (setting.energy_stone) < need then
				return
			end			

			pc.change_gold(-charge)
			pc.remove_item(setting.energy_stone, need)

			if pc.getqf("hasExperience") == 0 then
				say_title(mob_name(20001)) 
				say("Hier, dein Energiekristall. Doch nur der erste[ENTER]Versuch ist immer erfolgreich. Die Alchemie ist[ENTER]eine unberechenbare Wissenschaft - geringfügige[ENTER]Abweichungen führen zum Scheitern! Es besteht[ENTER]also immer ein kleines Risiko, dass das[ENTER]Experiment misslingen kann.")
				pc.give_item2 (setting.charging_stone, 1)
				pc.setqf("hasExperience", 1)
				return
			end

			local r = number (1, 100)
			if r > 30 then
				say_title(mob_name(20001)) 
				say("Leider ist der Versuch fehlgeschlagen. Ich konnte[ENTER]keinen Energiekristall herstellen. Meine Technik[ENTER]ist brillant - aber die Ausführung steckt nun mal[ENTER]voller Risiken. Nicht immer funktioniert alles[ENTER]nach Plan.[ENTER]Beim nächsten Mal haben wir bestimmt Erfolg!")
				return
			end
			say_title(mob_name(20001)) 
			say("Ich wusste es! Meine Technik ist brillant![ENTER]Hier ist dein Energiekristall.[ENTER]Ein Prachtexemplar! Spürst du die Kraft?")
			pc.give_item2(setting.charging_stone, 1)

		end
	end
end
