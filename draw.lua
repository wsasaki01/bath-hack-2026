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
		-- Centre camera on player
		camera(p.x-60,p.y-60)

		-- Draw map
		map(0,0,0,0,8,8)

		-- Projectile drawing
		for pr in all(projs) do
			pr:draw()
		end

		p:draw()

		-- Reset camera (draw all UI after this)
		camera()
		local secs = time
		local mins = flr(time / 60)
		local nice_secs = time % 60
		print("\#0"..mins..":"..(nice_secs<10 and "0" or "")..secs, 100,0,7)
	end


	-- Menu transition
	if counters.trans_cnt != -1 then
		local x = (30-counters.trans_cnt)/30 * 256
		rectfill(x-128, 0, x, 128, 0)
	end

	-- DEBUG: CPU and Mem usage
	debugs = {
		"cpu "..tostr(flr(stat(1)*100)).."%",
		"mem "..tostr(stat(0)/1024).."MB",
	}

	local i=0
	for d in all(debugs) do
		print("\#0"..d,1,1+i*6,7)
		i+=1
	end
end