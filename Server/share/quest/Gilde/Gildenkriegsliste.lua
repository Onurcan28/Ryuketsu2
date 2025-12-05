quest guild_war_observer begin
    state start begin
		when guild_war_observer1.chat."Laufende Gildenkriege"
			or guild_war_observer2.chat."Laufende Gildenkriege" 
			or guild_war_observer3.chat."Laufende Gildenkriege" begin
			local g = guild.get_warp_war_list()
			local gname_table = {}
			table.foreachi(g,
				function(n, p) 
					gname_table[n] = guild.get_name(p[1]).." vs "..guild.get_name(p[2])
				end
			)
			if table.getn(g) == 0 then
				say_title("Schlachtenverwalter")
				say("Zur Zeit finden keine Gildenkriege statt.")
				return
			end
			say_title("Schlachtenverwalter")
			gname_table[table.getn(g)+1] = locale.confirm
			local s = select_table(gname_table)
			say_reward("Welchen möchtest du beitreten?")
			if s != table.getn(gname_table) then
				pc.warp_to_guild_war_observer_position(g[s][1], g[s][2])
			end
		end	
    end
end

