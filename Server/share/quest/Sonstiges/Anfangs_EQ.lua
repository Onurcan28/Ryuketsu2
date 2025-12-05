quest give_basic_weapon begin
	state start begin
		when login with pc.getqf("basicweapon") == 0 begin
			if pc.job == 0 then
				pc.give_item2(11209, 1)
				pc.give_item2(12209, 1)
				pc.give_item2(19, 1)
				pc.give_item2(3009, 1)
			elseif pc.job == 1 then    
				pc.give_item2(11409, 1)
				pc.give_item2(12349, 1)
				pc.give_item2(2009, 1)
				pc.give_item2(1009, 1)
				pc.give_item2(8000, 200)
			elseif pc.job == 2 then
				pc.give_item2(11609, 1)
				pc.give_item2(12489, 1)
				pc.give_item2(19, 1)
			elseif pc.job == 3 then
				pc.give_item2(11809, 1)
				pc.give_item2(12629, 1)
				pc.give_item2(7009, 1)
			elseif pc.job == 4 then
				pc.give_item2(21009, 1)
				pc.give_item2(21509, 1)
				pc.give_item2(6009, 1)
			end
			pc.give_item2(13009 , 1)
			pc.give_item2(14009 , 1)
			pc.give_item2(15009 , 1)
			pc.give_item2(16009 , 1)
			pc.give_item2(17009 , 1)
			pc.give_item2(70038 , 200)
			pc.give_item2(72723 , 1)
			pc.give_item2(72727 , 1)
			pc.give_item2(72701 , 1)
			pc.give_item2(50053 , 1)
			pc.give_item2(70007 , 1)
			horse.set_level(21)  
			horse.ride ()
			pc.setqf("basicweapon", 1)
			set_state(__complete)
		end
	end
	state __complete begin
	end
end