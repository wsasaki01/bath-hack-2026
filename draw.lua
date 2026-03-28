function _draw()
	-- Draw background
	cls(7)

	-- Title Screen
	if menu==1 then
		print("bh26 game !!!!\n", 20, 50, 0)
		print((menu_idx==1 and "\f7\#0" or "").."start game", 20, 60, 0)
		print((menu_idx==2 and "\f7\#0" or "").."second thing idk", 20, 70, 0)

	-- Game
	elseif menu==2 then
		-- Projectile drawing
		for pr in all(projs) do
			pr:draw()
		end
	end

	-- Menu transition
	if counters.trans_cnt != -1 then
		local x = (30-counters.trans_cnt)/30 * 256
		rectfill(x-128, 0, x, 128, 0)
	end

	-- DEBUG: CPU and Mem usage
	print("\#0cpu "..tostr(flr(stat(1)*100)).."%",1,1,7)
	print("\#0mem "..tostr(stat(0)/1024).."MB")
end