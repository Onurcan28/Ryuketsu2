quest guild_building_npc begin
    state start begin
		when 20044.click begin
			if npc.get_guild() == pc.get_guild() then
				say("Ah! Seid Gegrüßt!")
				say("Ich kann Waffen um 10% besser verbessern als")
				say("der Dorfschmied. Als Gildenmitglied")
				say("Erhalten sie natuerlich einen Preisnachlass")
				say("von 5%!")
			else
				say("Ich bin der Schmied der für Waffen zuständig ist!")
				say("Der Dorfschmied bekommt das nicht so gut")
				say("hin, ist aber auch wesentlich billiger als ich.")
				say("Aber ich schaffe 10% mehr als er.")
			end
		end
		when 20045.click begin
			if npc.get_guild() == pc.get_guild() then
				say("Ah! Seid Gegrüßt!")
				say("Ich kann Rüstungen um 10% besser verbessern als")
				say("der Dorfschmied. Als Gildenmitglied")
				say("Erhalten sie natuerlich einen Preisnachlass")
				say("von 5%! Als Rüstungen zählen natürlich")
				say("auch Schilde und Helme.")
			else
				say("Ich bin der Schmied der für Ruestungen zuständig ist!")
				say("Ausserdem verbessere ich auch Helme und Schilde")
				say("Der Dorfschmied bekommt das nicht so gut")
				say("hin, ist aber auch wesentlich billiger als ich.")
				say("Aber ich schaffe 10% mehr als er.")
			end
		end
		when 20046.click begin
			if npc.get_guild() == pc.get_guild() then
				say("Ah! Seid Gegrüßt!")
				say("Ich kann Schmuck um 10% besser verbessern als")
				say("der Dorfschmied. Als Gildenmitglied")
				say("Erhalten sie natürlich einen Preisnachlass")
				say("von 5%! Als Schmuck zählen natürlich")
				say("Ohrringe, Ketten, Armbänder und Schuhe.")
			else
				say("Ich bin der Schmied der fuer Schmuck zuständig ist!")
				say("Der Dorfschmied bekommt das nicht so gut")
				say("hin, ist aber auch wesentlich billiger als ich.")
				say("Aber ich schaffe 10% mehr als er.")
			end
		end
    end
end