quest alter_of_power begin
	state start begin
		when 20077.click with npc.get_guild() == pc.get_guild() and pc.is_guild_master() begin
			say_title(mob_name(20077))
			say("Ich bin der Wächter dieses Altars.")
			say("Der Altar erhöht die maximale Zahl")
			say("der Mitglieder in Ihrer Gilde. ")
			say("Ihr können dieses Altar ausbauen, um")
			say("diese Zahl noch zu steigern.")
			if pc.getqf("build_level") == 0 then
				pc.setqf("build_level", guild.level(pc.get_guild()))
			end
			wait()
			say_title(mob_name(20077))
			if pc.getqf("build_level") < guild.level(pc.get_guild()) or guild.level(pc.get_guild()) >= 20 then
				say("Das Altar auszubauen kostet euch:")
				say_reward("25.000.000 Yang")
				say_reward("10 Fundamentsteine")
				say_reward("10 Stämme")
				say_reward("15 Sperrhölzer")
				local s=select("Bauen", "Nein, zu teuer")
				if s == 1 then
					say_title(mob_name(20077))
					if pc.count_item(90010) >= 10 and pc.count_item(90012) >= 15 and pc.count_item(90011) >= 10 and pc.get_gold() >= 25000000 then
						say("Das Altar wurde erweitert!")
						building.reconstruct(14062)
						pc.setqf("build_level", guild.level(pc.get_guild()))
						pc.change_gold(-25000000)
						pc.remove_item("90010", 10)
						pc.remove_item("90011", 10)
						pc.remove_item("90012", 15)
					else
						say("Du hast nicht alle benötigten")
						say("Materialien. Hole diese zuerst.")
					end
				elseif s == 2 then
					say("Wie du meinst.")
				end
			else
				say("Ihr könnt jetzt nicht bauen.")
			end
		end
		when 20078.click with npc.get_guild() == pc.get_guild() and pc.is_guild_master() begin
			say_title(mob_name(20078))
			say("Ich bin der Wächter dieses Altars.")
			say("Der Altar erhöht die maximale Zahl")
			say("der Mitglieder in Ihrer Gilde. ")
			say("Ihr können dieses Altar ausbauen, um")
			say("diese Zahl noch zu steigern.")
			if pc.getqf("build_level") == 0 then
				pc.setqf("build_level", guild.level(pc.get_guild()))
			end
			wait()
			say_title(mob_name(20078))
			if pc.getqf("build_level") < guild.level(pc.get_guild()) or guild.level(pc.get_guild()) >= 20 then
				say("Das Altar auszubauen kostet euch:")
				say_reward("30.000.000 Yang ")
				say_reward("15 Fundamentsteine")
				say_reward("20 Stämme")
				say_reward("20 Sperrhölzer")
				local s=select("Bauen", "Nein, zu teuer")
				if s==1 then
					say_title(mob_name(20078))
					if pc.count_item(90010) >= 15 and pc.count_item(90012) >= 20 and pc.count_item(90011) >= 20 and pc.get_gold() >= 30000000 then
						say("Das Altar wurde erweitert!")
						building.reconstruct(14063)
						pc.setqf("build_level", guild.level(pc.get_guild()))
						pc.change_gold(-30000000)
						pc.remove_item("90010", 15)
						pc.remove_item("90011", 20)
						pc.remove_item("90012", 20)
					else
						say("Du hast nicht alle benätigten")
						say("Materialien. Hole diese zuerst.")
					end
				elseif s == 2 then
					say("Wie du meinst.")
				end
			end
		end
		when 20079.click with npc.get_guild() == pc.get_guild() and pc.is_guild_master() begin
			say_title(mob_name(20079))
			say("Das Altar ist bereits maxmimal ausgebaut.")
			say("Ich kann es nicht weiter erweitern.")
		end
	end
end