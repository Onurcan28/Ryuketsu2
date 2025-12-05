quest guild_ranking begin
    state start begin
		when 11000.chat."Eigenen Gildenrang anzeigen" or 11002.chat."Eigenen Gildenrang anzeigen" or 11004.chat."Eigenen Gildenrang anzeigen" with pc.hasguild() begin
			say_title("Wächter des Dorfplatzes")
			say("Hier siehst du den Gildenrang deiner Gilde.")
			say(guild.around_ranking_string().."[/DELAY]")
		end
		when 11000.chat."Beste Gilden anzeigen" or 11002.chat."Beste Gilden anzeigen" or 11004.chat."Beste Gilden anzeigen" with pc.hasguild() begin
			say_title("Wächter des Dorfplatzes")
			say("Hier siehst du die besten Gilden.")
			say(guild.high_ranking_string().."[/DELAY]")
		end
		when 11000.chat."Gilde ansehen" or 11002.chat."Gilde ansehen" or 11004.chat."Gilde ansehen" with pc.hasguild() begin
			say_title("Wächter des Dorfplatzes")
			say("Deine Gilde befindet sich auf:")
			say_reward("Platz: "..guild.get_rank()..", mit "..guild.get_ladder_point().." Punkten!")
		end		
    end
end

