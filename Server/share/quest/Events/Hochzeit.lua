quest marriage_manage begin
	state start begin
		when oldwoman.chat."Ich möchte heiraten." with not pc.is_engaged_or_married() begin
			if not npc.lock() then
				say_title("Alte Frau:")
				say("Derzeit findet eine andere Hochzeit statt. Bitte[ENTER]warte einen Moment oder komme später wieder!")
				return
			end

			if pc.get_level() < 25 then
				say_title("Alte Frau:")
				say("Bist du nicht noch zu jung, um zu heiraten? Man[ENTER]braucht viel Verantwortungen für das Eheleben und[ENTER]dazu scheinst du mir noch nicht reif genug. Junge[ENTER]Leute lassen sich zu schnell scheiden, daher[ENTER]werde ich es nicht genehmigen. Du solltest[ENTER]zunächst noch Erfahrungen sammeln.")
				say_title("Information:")
				say_reward("Eine Hochzeit kann erst ab Level 25 durchgeführt[ENTER]werden.")
				npc.unlock()
				return
			end

			local m_ring_num = pc.countitem(70301)
			local m_has_ring = m_ring_num > 0
			if not m_has_ring then
				say_title("Alte Frau:")
				say("Du möchtest ohne Ring heiraten?")
				say_item("Verlobungsring", 70301, "")
				say("Du musst erst einen Verlobungsring besorgen.[ENTER]Dann darfst du heiraten.")
				npc.unlock()
				return
			end

			local m_sex = pc.get_sex()
			local m_nationality = pc.get_empire()
			if not marriage_manage.is_equip_wedding_dress() then
				say_title("Alte Frau:")
				say("Willst du wirklich so heiraten? Das ist eine[ENTER]wichtige Situation in deinem Leben, du solltest[ENTER]dich daher ein wenig festlicher kleiden.")

				if m_sex == 0 then
					say_item("Smoking", marriage_manage.get_wedding_dress(m_sex), "")
					say_reward("Wenn du heiraten möchtest, musst du einen Smoking[ENTER]tragen.")
				else
					say_item("Brautkleid", marriage_manage.get_wedding_dress(m_sex), "")
					say_reward("Wenn du heiraten möchtest, musst du ein[ENTER]Brautkleid anziehen.")
				end
				npc.unlock()
				return
			end

			local NEED_MONEY = 1000000
			if pc.get_money() < NEED_MONEY then
				say_title("Alte Frau:")
				say("Nur mit Liebe allein lässt sich leider keine[ENTER]Hochzeit arrangieren, du benötigst auch etwas[ENTER]Yang. Deine Ersparnisse reichen bisher aber nicht[ENTER]aus. Wenn du eine Million Yang gespart hast,[ENTER]werde ich gerne die Zeremonie planen.")
				say_reward("Du benötigst eine Million Yang.")
				npc.unlock()
				return
			end

			say_title("Alte Frau:")
			say("Ja, das richtige Alter hast du, ebenfalls den[ENTER]entschlossenen Gesichtsausdruck. Wen möchtest du[ENTER]heiraten?")
			say_reward("Bitte gib den Namen der Person an, die du zu[ENTER]heiraten wünschst.")

			local sname = input()
			if sname == "" then
				say_title("Alte Frau:")
				say("Bist du so aufgeregt, dass du nicht einmal den[ENTER]Namen niederschreiben kannst? Versuche es noch[ENTER]einmal.")
				npc.unlock()
				return
			end

			local u_vid = find_pc_by_name(sname)
			local m_vid = pc.get_vid()
			if u_vid == 0 then
				say_title("Alte Frau:")
				say("Du weißt also den Namen der Person nicht, die du[ENTER]zu heiraten wünschst? Du bist dir aber sicher,[ENTER]dass du eine Hochzeit möchtest?")
				say_reward(string.format("%s ist nicht online.", sname))
				npc.unlock()
				return
			end

			if not npc.is_near_vid(u_vid, 10) then
				say_title("Alte Frau:")
				say("Dein Partner muss in der Nähe sein, damit ich die[ENTER]Zeremonie durchführen kann.[ENTER]Bringe ihn also bitte her.")
				say_reward(string.format("%s befindet sich zu weit weg.", sname))
				npc.unlock()
				return
			end

			local old = pc.select(u_vid)
			local u_level = pc.get_level()
			local u_job = pc.get_job()
			local u_sex = pc.get_sex()
			local u_nationality = pc.get_empire()
			local u_name = pc.get_name()
			local u_gold = pc.get_money()
			local u_married = pc.is_married()
			local u_has_ring = pc.countitem(70301) > 0
			local u_wear = marriage_manage.is_equip_wedding_dress()
			pc.select(old)

			local m_level = pc.get_level()

			if u_vid == m_vid then
				say_title("Alte Frau:")
				say("Hier benötige ich nicht deinen Namen, sondern den[ENTER]deines Partners.")
				say_reward("Gib hier den Namen deines Partners an.")
				npc.unlock()
				return
			end

			if u_sex == m_sex then
				say_title("Alte Frau:")
				say("Tut mir leid, aber gleichgeschlechtliche Paare[ENTER]kann ich nicht trauen.")
				npc.unlock()
				return
			end

			if u_nationality != m_nationality then
				say_title("Alte Frau:")
				say("Es können nur Paare aus demselben Reich heiraten.")
				npc.unlock()
				return
			end

			if u_married then
				say_title("Alte Frau:")
				say("Die Person die du zu heiraten wünschst, ist[ENTER]bereits verheiratet. Wusstest du das nicht? Du[ENTER]solltest dir einen ledigen Partner suchen.")
				say_reward(string.format("%s ist verheiratet.", sname))
				npc.unlock()
				return
			end

			if u_level < 25 then
				say_title("Alte Frau:")
				say("Die Person ist noch nicht bereit für die Ehe.[ENTER]Dein Partner sollte mindestens Level 25 besitzen.")
				npc.unlock()
				return
			end

			if m_level - u_level > 15 or u_level - m_level > 15 then
				say_title("Alte Frau:")
				say("Es tut mir leid, aber ich kann euch beide nicht[ENTER]trauen. Ihr passt nicht zueinander, da eure[ENTER]Erfahrungs-Differenz mehr als 15 Level beträgt.")
				npc.unlock()
				return
			end

			if not u_has_ring then
				if m_ring_num >= 2 then
					say_title("Alte Frau:")
					say("Nun tauscht die Ringe. ")
				else
					say("Die Heiraten ist eine wichtige Angelegenheit im[ENTER]Leben, da hätte dein Partner doch wenigstens[ENTER]einen Ehering mitbringen können? ")
				end

				say_item("Verlobungsring", 70301, "")
				say_title("Alte Frau:")
				say("Dein Partner muss ebenfalls einen Ehering bei[ENTER]sich haben. ")
				npc.unlock()
				return
			end

			if not u_wear then
				say_title("Alte Frau:")
				say("Dein Partner trägt gar kein Hochzeitsgewand![ENTER]Ist dir das nicht peinlich? ")
				if u_sex == 0 then
					say_title("Alte Frau:")
					say_item("Smoking", marriage_manage.get_wedding_dress(u_sex), "")
					say("Dein Partner muss einen Smoking tragen.")
				else
					say_title("Alte Frau:")
					say_item("Brautkleid", marriage_manage.get_wedding_dress(u_sex), "")
					say("Deine Partnerin muss ein Brautkleid tragen.")
				end
				npc.unlock()
				return
			end

			local ok_sign = confirm(u_vid, string.format("%s hat dir einen Heiratsantrag gemacht. Annehmen?", pc.get_name()), 30)

			if ok_sign == CONFIRM_OK then
				local m_name = pc.get_name()
				if pc.get_gold() >= NEED_MONEY then
					pc.change_gold(-NEED_MONEY)

					pc.removeitem(70301, 1)
					pc.give_item2(70302, 1)
					local old = pc.select(u_vid)
					pc.removeitem(70301, 1)
					pc.give_item2(70302, 1)
					pc.select(old)

					say_title("Alte Frau:")
					say("Nun ist es so weit: Ihr zwei habt den Bund der[ENTER]Ehe geschlossen und könnt nun ein wenig Zeit[ENTER]miteinder verbringen. Ich werde euch zu der Insel[ENTER]der Liebenen schicken. Eine lange und glückliche[ENTER]Ehe wünsche ich euch, meine Gratulation.[ENTER]Demnächst wirst du automatisch zur Insel der[ENTER]Liebenen geschickt. ")
					wait()
					setskin(NOWINDOW)
					marriage.engage_to(u_vid)
				end
			else
				say_title("Alte Frau:")
				say("Dein Partner hat anscheinend nicht die Absicht,[ENTER]dich zu heiraten. Vielleicht solltest du das[ENTER]zunächst klären. ")
			end
			npc.unlock()
		end

		when oldwoman.chat."Zurück zum Hochzeitsraum" with pc.is_engaged() begin
			say_title("Alte Frau:")
			say("Warum bist du immer noch hier?[ENTER]Dein Partner wartet bereits sehnsüchtig auf dich.[ENTER]Du solltest rasch folgen. ")
			wait()
			setskin(NOWINDOW)
			marriage.warp_to_my_marriage_map()
		end

		when 9011.chat."Genehmigung für die Hochzeit" with pc.is_engaged() and marriage.in_my_wedding() begin
			if not npc.lock() then
				say_title("Hochzeitsplanerin:")
				say("Ich spreche mit deinem Partner. Gedulde dich[ENTER]bitte einen Moment.")
				return
			end

			say_title("Hochzeitsplanerin:")
			say("Ich bin hier, um den reibungslosen Ablauf eurer[ENTER]Zeremonie zu gewährleisten. Zunächst notiere hier[ENTER]unten den Namen deines Partners.")

			local sname = input()
			local u_vid = find_pc_by_name(sname)
			local m_vid = pc.get_vid()

			local old = pc.select(u_vid)
			pc.select(old)

			if u_vid == 0 then
				say_title("Hochzeitsplanerin:")
				say("Dieser Name ist nicht registriert.[ENTER]Ãœberprüfe bitte deine Angaben.")
				say_reward(string.format("%s ist nicht online.", sname))
				npc.unlock()
				return
			end

			if not npc.is_near_vid(u_vid, 10) then
				say_title("Hochzeitsplanerin:")
				say("Hole bitte deinen Partner her. Ich muss mit ihm[ENTER]reden, um einige Dinge zu prüfen.")
				say_reward(string.format("%s ist noch zu weit entfernt.", sname))
				npc.unlock()
				return
			end

			if u_vid == m_vid then
				say_title("Hochzeitsplanerin:")
				say("Du musst den Name deines Partners schreiben,[ENTER]nicht deinen eigenen.")
				npc.unlock()
				return
			end

			if u_vid != marriage.find_married_vid() then
				say_title("Hochzeitsplanerin:")
				say("Hier stimmt was nicht - das ist nicht die Person,[ENTER]die mir angekündigt wurde.")
				npc.unlock()
				return
			end

			local ok_sign = confirm(u_vid, string.format("%s hat dir einen Heiratsantrag gemacht. Annehmen?", pc.get_name()), 30)
			if ok_sign != CONFIRM_OK then
				say_title("Hochzeitsplanerin:")
				say("Dein Partner scheint noch nicht bereit für die[ENTER]Hochzeit zu sein. Klärt das untereinander.")
				npc.unlock()
				return
			end
			say_title("Hochzeitsplanerin:")
			say("Nun sind alle Vorbereitungen getroffen. Die[ENTER]Zeremonie kann beginnen.")
			marriage.set_to_marriage()
			say("Das wird eine wunderschöne Hochzeit!")
			npc.unlock()
		end

		function give_wedding_gift()
			local male_item = {71072, 71073, 71074}
			local female_item = {71069, 71070, 71071}
			if pc.get_sex() == MALE then
				pc.give_item2(male_item[number(1, 3)], 1)
			else
				pc.give_item2(female_item[number(1, 3)], 1)
			end
		end

		when 9011.chat."Beginn des Hochzeitsmarsches" with
			(pc.is_engaged() or pc.is_married()) and
			marriage.in_my_wedding() and
			not marriage.wedding_is_playing_music()
		begin
			marriage.wedding_music(true, "wedding.mp3")
			setskin(NOWINDOW)
		end

		when 9011.chat."Hochzeitsmarsch beenden" with
			(pc.is_engaged() or pc.is_married()) and
			marriage.in_my_wedding() and
			marriage.wedding_is_playing_music()
		begin
			marriage.wedding_music(false, "default")
			setskin(NOWINDOW)
		end

		when 9011.chat."Nacht" with pc.is_married() and marriage.in_my_wedding() begin
			marriage.wedding_dark(true)
			setskin(NOWINDOW)
		end

		when 9011.chat."Schnee" with pc.is_married() and marriage.in_my_wedding() begin
			marriage.wedding_snow(true)
			setskin(NOWINDOW)
		end

		when 9011.chat."Ende der Hochzeit" with pc.is_married() and marriage.in_my_wedding() begin
			if not npc.lock() then
				say_title("Hochzeitsplanerin:")
				say("Bitte warte einen Moment, ich spreche gerade mit[ENTER]deinem Partner.")
				return
			end

			say_title("Hochzeitsplanerin:")
			say("Möchtest du die Hochzeit fortsetzen?")
			local s = select("Ja", "Nein")
			if s == 2 then
				local u_vid = marriage.find_married_vid()

				local old = pc.select(u_vid)
				pc.select(old)

				if u_vid == 0 then
					say_title("Hochzeitsplanerin:")
					say("Dein Partner muss mit dem Abbruch der Hochzeit[ENTER]einverstanden sein. Sie kann jetzt nicht beendet[ENTER]werden, da dein Partner nicht online ist.")
					npc.unlock()
					return
				end

				say_title("Hochzeitsplanerin:")
				say("Ohne die Zustimmung deines Partners können wir[ENTER]die Zeremonie nicht durchführen. Du musst dich[ENTER]daher ein wenig gedulden.")
				local ok_sign = confirm(u_vid, "Wünschst du die Hochzeit zu beenden?", 30)
				if ok_sign == CONFIRM_OK then
					marriage.end_wedding()
				else
					say_title("Hochzeitsplanerin:")
					say("Dein Partner möchte nicht.")
				end
			end
			npc.unlock()
		end

		when 11000.chat."Scheidung" or
			11002.chat."Scheidung" or
			11004.chat."Scheidung" with pc.is_married() begin

			if not marriage_manage.check_divorce_time() then
				return
			end

			local u_vid = marriage.find_married_vid()
			if u_vid == 0 or not npc.is_near_vid(u_vid, 10) then
				say_title("Wächter des Dorfplatzes:")
				say("Es ist nicht möglich, in Abwesenheit deines[ENTER]Partners eine Scheidung durchzuführen. Ihr müsst[ENTER]noch einmal zusammen wiederkommen.")
				return
			end

			say_title("Wächter des Dorfplatzes:")
			say("Für die rechtmäßige Scheidung benötigst du[ENTER]500.000 Yang und das Einverständnis deines[ENTER]Partners.[ENTER]Willst du dich wirklich scheiden lassen?")

			local MONEY_NEED_FOR_ONE = 500000
			local s = select("Ja.", "Nein, war nur ein Scherz.")

			if s == 1 then
				local m_enough_money = pc.gold > MONEY_NEED_FOR_ONE
				local m_have_ring = pc.countitem(70302) > 0

				local old = pc.select(u_vid)
				local u_enough_money = pc.get_gold() > MONEY_NEED_FOR_ONE
				local u_have_ring = pc.countitem(70302) > 0
				pc.select(old)

				if not m_have_ring then
					say("Den Ehering bitte.")
					return;
				end

				if not u_have_ring then
					say("Auch dein Partner muss seinen Ring hier bei sich[ENTER]haben.")
					return;
				end

				if not m_enough_money then
					say_title("Wächter des Dorfplatzes:")
					say("Die Summe reicht leider nicht, um die Scheidung[ENTER]durchzuführen.")
					say_reward(string.format("Um sich scheiden zu lassen, benötigt man %s Yang.", MONEY_NEED_FOR_ONE))
					return;
				end

				if not u_enough_money then
					say_title("Wächter des Dorfplatzes:")
					say("Die Summe reicht leider nicht, um die Scheidung[ENTER]durchzuführen.")
					say_reward("Man benötigt 500.000 Yang für eine Scheidung.")
					return;
				end

				say_title("Wächter des Dorfplatzes:")
				say("Willst du dich wirklich scheiden lassen?[ENTER]Das ist eine Entscheidung, die man nicht[ENTER]leichtfertig fällen sollte.")

				local c = select("Ja.", "Nein. Ich habe meine Meinung geändert.")
				if 2 == c then
					say_pc_name()
					say("Ich habe meine Meinung geändert.[ENTER]Ich möchte mich nicht scheiden lassen.")
					wait()
					say_title("Wächter des Dorfplatzes:")
					say("Es ist besser auf diese Weise. Ich wünsche dir[ENTER]ein langes und schönes Leben.")
					say_reward("Die Scheidung ist vollzogen.")
					return
				end

				local ok_sign = confirm(u_vid, "Bist du einverstanden mit der Scheidung?", 30)
				if ok_sign == CONFIRM_OK then
					local m_enough_money = pc.gold > MONEY_NEED_FOR_ONE
					local m_have_ring = pc.countitem(70302) > 0

					local old = pc.select(u_vid)
					local u_enough_money = pc.gold > MONEY_NEED_FOR_ONE
					local u_have_ring = pc.countitem(70302) > 0
					pc.select(old)

					if m_have_ring and m_enough_money and u_have_ring and u_enough_money then
						pc.removeitem(70302, 1)
						pc.change_money(-MONEY_NEED_FOR_ONE)

						local old = pc.select(u_vid)
						pc.removeitem(70302, 1)
						pc.change_money(-MONEY_NEED_FOR_ONE)
						pc.select(old)

						say_title("Wächter des Dorfplatzes:")
						say("Die Scheidung ist vollzogen.[ENTER]Ihr seid nun geschieden.")
						say_reward("Die Scheidung ist vollzogen.")
						marriage.remove()
					else
						say_title("Wächter des Dorfplatzes:")
						say("Diese Unterlagen sind nicht vollständig.[ENTER]Du musst daher noch einmal wiederkommen.")
						say_reward("Die Scheidung wird für ungültig erklärt.")
					end
				else
					say_title("Wächter des Dorfplatzes:")
					say("Der Partner verweigert die Scheidung.[ENTER]Ihr solltet dies zunächst klären.")
					say_reward("Die Scheidung wird für ungültig erklärt.")
				end
			end
		end

		when 11000.chat."Ehering wegstecken" or
			11002.chat."Ehering wegstecken" or
			11004.chat."Ehering wegstecken" with
			not pc.is_married() and
			pc.count_item(70302) > 0
		begin
			say_title("Wächter des Dorfplatzes:")
			say("Unangenehme Erinnerungen sollte man schnell[ENTER]hinter sich lassen.")
			say_reward("Der Ehering wurde weggesteckt.")
			pc.remove_item(70302)
		end

		when 11000.chat."Einseitige Scheidung" or
			11002.chat."Einseitige Scheidung" or
			11004.chat."Einseitige Scheidung" with pc.is_married() begin

			if not marriage_manage.check_divorce_time() then
				return
			end

			say_title("Wächter des Dorfplatzes:")
			say("Du benötigst eine Million Yang für die einseitige[ENTER]Scheidung. Bist du sicher, dass du dich scheiden[ENTER]lassen willst?")

			local s = select("Ja.", "Nein, ich wollte nur einmal nachfragen.")
			if s == 2 then
				return
			end

			local NEED_MONEY = 1000000

			if pc.get_money() < NEED_MONEY then
				say_title("Wächter des Dorfplatzes:")
				say("Deine Ersparnisse reichen nicht aus für eine[ENTER]Scheidung. Du benötigst dazu genauso viel Yang[ENTER]wie für deine Hochzeit.")
				return
			end

			say_title("Wächter des Dorfplatzes:")
			say("Bist du dir sicher, dass du dich scheiden lassen[ENTER]willst?")

			local c = select("Ja, ich will.", "Ich sollte das noch einmal überdenken.")

			if c == 2 then
				say_title("Wächter des Dorfplatzes:")
				say("Nun, womöglich ist es besser so. Wenn du sicher[ENTER]bist, dass du es wirklich möchtest, dann komme[ENTER]noch einmal wieder.")
				return
			end

			pc.removeitem(70302, 1)
			pc.change_gold(-NEED_MONEY)

			marriage.remove()

			say_title("Wächter des Dorfplatzes:")
			say("Da du dir sicher bist, werde ich die Scheidung[ENTER]nun vollziehen. Ich wünsche euch dennoch alles[ENTER]Gute für die Zukunft.")
		end

		when oldwoman.chat."Liste der Hochzeiten" with not pc.is_engaged() begin
			local t = marriage.get_wedding_list()
			if table.getn(t) == 0 then
				say_title("Alte Frau:")
				say("Es findet zurzeit keine Hochzeit statt.")
			else
				local wedding_names = {}
				table.foreachi(t, function(n, p) wedding_names[n] = string.format("Hochzeit von %s und %s", p[3], p[4]) end)
				wedding_names[table.getn(t) + 1] = "Bestätigen"
				local s = select_table(wedding_names)

				if s != table.getn(wedding_names) then
					marriage.join_wedding(t[s][1], t[s][2])
				end
			end
		end

		when 9011.click with not pc.is_engaged() and not pc.is_married() begin
			say_title("Hochzeitsplanerin:")
			say("Du bist Hochzeitgast! Viel Spaß!")
		end

		function check_divorce_time()
			local DIVORCE_LIMIT_TIME = 86400

			if is_test_server() then
				DIVORCE_LIMIT_TIME = 60
			end

			if marriage.get_married_time() < DIVORCE_LIMIT_TIME then 
				say_title("Wächter des Dorfplatzes:")
				say("Die Tinte ist doch nicht einmal trocken![ENTER]Lass dir ein wenig mehr Zeit.")
				return false
			end

			return true
		end

		function is_equip_wedding_dress()
			local a = pc.get_armor()
			return a >= 11901 and a <= 11904
		end

		function get_wedding_dress(pc_sex)
			if 0 == pc_sex then
				return 11901
			else
				return 11903
			end
		end
	end
end
