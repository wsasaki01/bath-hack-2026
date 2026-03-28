function _draw()
	-- Draw background
	cls(0)
	
	-- Title Screen
	if menu==1 then
		print("bh26 game !!!!\n", 20, 50, 0)
		print(menu_pre(1).."start game", 20, 60)
		print(menu_pre(2).."second thing idk", 20, 70)

	-- Game
	elseif menu==2 then
		-- Centre camera on player
		camera(plyr.x-60,plyr.y-60)

		-- Draw map
		map(0,0,0,0,8,8)

		-- Draw player
		plyr:draw()

		-- Drawing enemies
		for enemy in all(enemies) do 
			enemy:draw()		-- Draw enemies
			enemy:draw_projs()	-- Draw projectiles honing in on that enemy
		end

		-- Reset camera (draw all UI after this)
		camera()

		rectfill(0,120,128,128,6)	-- Main XP bar
		rectfill(107,109,128,128)	-- Level background
		print("LEVEL",108,109,1)
		print("\^t\^w"..(plyr.level<10 and "0" or "")..plyr.level,111,116)
		rectfill(1,121,106,126,7)	-- Collected XP
		rectfill(1,121,1+105*plyr.xp/100,126,12)	-- Collected XP

		if selecting_item then
			rectfill(10,10,118,118)
		-- End screen
		elseif end_screen then
			rectfill(40,40,100,100,5)
			print("end!", 60, 50, 0)
			print(menu_pre(1).."replay", 45, 60)
			print(menu_pre(2).."back to title")
		end

		-- Timer
		local secs = time
		local mins = flr(time / 60)
		local nice_secs = time % 60
		print("\#0"..mins..":"..(nice_secs<10 and "0" or "")..secs, 100,0,7)
		print("player health: "..plyr.h)

		
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
		tostr(pause)
	}

	local i=0
	for d in all(debugs) do
		print("\#0"..d,1,1+i*6,7)
		i+=1
	end
end

-- Control code prefix for selected menu item
function menu_pre(idx)
	return menu_idx==idx and "\f7\#0" or "\f0"
end
