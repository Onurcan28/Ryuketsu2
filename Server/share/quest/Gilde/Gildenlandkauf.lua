quest guild_building begin
    state start begin
		when 20040.click begin
			say_title("Grundstücksverwalter")
			say("Ich bin Grundstücksverwalter und zuständig für")
			say("den Verkauf von Landflächen. Bevor die Monster")
			say("das Land in der Mitte des Kontinents besetzten,")
			say("hatten wir nicht unter Landknappheit zu leiden")
			say("und es ging allen gut. Jetzt verkaufe ich das")
			say("Land nur noch an die Gildenanführer, die es als")
			say("Gildenland nutzen. Willst du dieses Grundstück")
			say("kaufen?")
			local s = select("Ja", "Nein")
			if s == 1 then
				local land_id = building.get_land_id(pc.get_map_index(), pc.get_x()*100, pc.get_y()*100)
				local price, owner, guild_level_limit = building.get_land_info(land_id)
				say_title("Grundstücksverwalter")
				if not pc.is_guild_master() then				
					say("Ich kann dir dieses Land nicht verkaufen,")
					say("da du nicht der Gildenleader bist.")
					return
				elseif building.has_land(pc.get_guild()) then
					say("Ihr besitzt schon ein Gildenland.")
					return
				elseif guild.level(pc.get_guild()) < guild_level_limit then
					say("Euer Gildenlevel ist zu niedrig.")
					return
				elseif land_id == 0 then
					say("Land ID konnte nicht ermittelt werden.")
					return
				elseif owner != 0 then
					say("Dieses Stück Land wurde bereits gekauft.")
					return
				end
				say("Für dieses Land fallen folgende Kosten an.")
				say("Kaufpreis: "..price.." Yang.")
				say("Willst du dieses Land wirklich kaufen?")
				s = select("Ja", "Nein")
				if s == 1 then
					say_title("Grundstücksverwalter")
					if pc.get_gold()<price then					
						say("Du hast nicht genug Yang.")
						return
					end
					pc.changegold(-price)
					building.set_land_owner(land_id, pc.get_guild())
					notice_all(guild.name(pc.get_guild()).." besitzt nun ein Gildenland!")
				end
			end
		end
	end
end

