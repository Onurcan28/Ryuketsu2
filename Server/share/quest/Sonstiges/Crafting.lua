quest cube begin
	state start begin
		when 20018.chat."Kräuterkunde" with pc.level >= 15 begin
			say_title("Baek-Go:")
			say("Sei gegrüßt! Hast du Interesse am Kauf von[ENTER]Tränken, die dich stärken oder gar heilen können?[ENTER]Ich bin Mediziner und habe mich daher lange Jahre[ENTER]mit der Herstellung solcher Tränke beschäftigt.[ENTER]Ich verfüge über einige Rezepte, die nirgendwo[ENTER]sonst erhältlich sind. Möchtest du sie[ENTER]ausprobieren?")
			wait()
			setskin(NOWINDOW)
			command("cube open")
		end

		when 20017.chat."Kräuterkunde" with pc.level >= 30 begin
			say_title("Yu-Hwan:")
			say("Es sind vier Soldaten. Sie sagen, dass sie im Tal[ENTER]von Seungryong von Beschwörern und Peinigern[ENTER]gefoltert und getötet wurden. Ich war derjenige,[ENTER]der sie dorthin beordert hat - in ihren Tod!")
			wait()
			setskin(NOWINDOW)
			command("cube open")
		end

		when 20022.chat."Das geheime Rezept" with pc.level >=45 begin
			say_title("Huahn-So:")
			say("Ich habe ein geheimes Rezept gefunden, das sich[ENTER]seit Langem im Besitz meiner Familie befindet.[ENTER]Damit kann ich einen Trank brauen, der dich[ENTER]nahezu unverwundbar macht! Hast du Interesse[ENTER]daran, meine Tränke auszuprobieren?")
			wait()
			setskin(NOWINDOW)
			command("cube open")
		end

		when 20018.chat."Alle Tränke herstellen" with pc.level >= 15 begin
			setskin(NOWINDOW)
			command("cube make all")
		end

		when 20017.chat."Alle Tränke herstellen" with pc.level >= 30 begin
			setskin(NOWINDOW)
			command("cube make all")
		end

		when 20022.chat."Alle Tränke herstellen" with pc.level >=45 begin
			setskin(NOWINDOW)
			command("cube make all")
		end
		when 20016.click begin --Schmied
			setskin(NOWINDOW)
			command("cube open")
		end
	end
end
