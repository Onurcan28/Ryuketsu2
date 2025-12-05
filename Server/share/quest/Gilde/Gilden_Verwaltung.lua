quest guild_manage begin
    state start begin	
		when 11000.chat."Gilde verlassen" or 11002.chat."Gilde verlassen" or 11004.chat."Gilde verlassen" with pc.hasguild() and not pc.isguildmaster() and npc.get_empire() == pc.get_empire() begin
		   say_title("Wächter des Dorfplatzes")
			say("Möchtest du deine Gilde wirklich")
			say("verlassen? Ich denke deine Member")
			say("werden enttäuscht von dir sein..")
			local s = select("Ja", "Nein")
			if s==1 then
				say_title("Wächter des Dorfplatzes")
				say("Du bist nun wieder Gildenlos!")
				pc.remove_from_guild()
				pc.setqf("new_withdraw_time",get_global_time())
			end
		end
		when 11000.chat."Gilde auflösen" or 11002.chat."Gilde auflösen" or 11004.chat."Gilde auflösen" with pc.hasguild() and pc.isguildmaster() and npc.get_empire() == pc.get_empire() begin
			say_title("Wächter des Dorfplatzes")
			say("Möchtest du deine Gilde wirklich")
			say("auflösen? Ich denke deine Member")
			say("werden enttäuscht von dir sein..")
			local s = select("Ja", "Nein")
			if s==1 then
				say_title("Wächter des Dorfplatzes")
				say("Deine Gilde ist nun aufgelöst!")
				pc.destroy_guild()
				pc.setqf("new_disband_time",get_global_time())
				pc.setqf("new_withdraw_time",get_global_time())
			end
		end

		when 11000.chat."Gilde gründen" or 11002.chat."Gilde gründen" or 11004.chat."Gilde gründen" with not pc.hasguild() and not pc.isguildmaster() and npc.get_empire() == pc.get_empire() begin	    
			if game.get_event_flag("guild_withdraw_delay")*86400 > 
			get_global_time() - pc.getqf("new_withdraw_time") or
			game.get_event_flag("guild_disband_delay")*86400 > 
			get_global_time() - pc.getqf("new_disband_time")	then
				say_title("Wächter des Dorfplatzes")
				say("Du kannst jetzt noch keine neue Gilde gründen!")
				say("Warte noch eine Weile!")
				return
			end
			say_title("Wächter des Dorfplatzes")
			say("Um eine neue Gilde zu gründen")
			say("brauchst du:")
			say("-Level 40")
			say("-500.000 Yang")
			say("Möchtest du eine Gilde gründen?")
			local s = select("Ja", "Nein")
			if s == 2 then
				return
			elseif pc.get_level()<40 then
				say_title("Wächter des Dorfplatzes")
				say("Du bist noch nicht Level 40.")
				return
			elseif pc.get_gold()<500000 then
				say_title("Wächter des Dorfplatzes")
				say("Du hast keine 500.000 Yang.")
				return
			end			
			game.request_make_guild()
		end
    end
end
