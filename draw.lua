function _draw()
	-- Draw background
	cls(7)
	
	-- Title Screen
	if menu==1 then
		print("bh26 game !!!!\n", 20, 50, 0)
		print((menu_idx==1 and "\f7\#0" or "").."start game", 20, 60, 0)
		print((menu_idx==2 and "\f7\#0" or "").."second thing idk", 20, 70, 0)
	elseif menu==2 then
		print("player health: "..plyr.h)

		
		-- testing enemy colour
		for enemy in all(enemiesSpr) do 
			enemy:draw(enemy)
		end
		plyr:draw()
	end
end