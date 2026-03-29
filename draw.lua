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

		-- Screen item updates
		for screen in all(screen_list) do
			screen:draw()
		end

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
		for i in all(items) do
			spr(i.data.spr,0,100)
		end

		if selecting_item then
			rrect(2,2,103,116,8,3)		-- Menu outline
			rrectfill(4,4,99,112,8,3)	-- Menu background
			print("level up!",37+flr(sin(global_cnt/100)*5),7,0)
			local y=15
			local j=0
			for i in all(random_items) do
				j+=1
				rrectfill(6,y,95,30,2,15)
				if (j==menu_idx) rrect(6,y,95,30,2,0)
				sspr(i.sprx,i.spry,8,8,12,y+6,16,16)
				print(i.name,32,y+6,0)
				print(i.desc,32,y+12,1)
				y+=32
			end
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

		for i=1,16 do
			for j=1,16 do
				print(screen_damage_mtrx[i][j],i*8-5,j*8-6,4,2)
			end
		end
	end

	-- Menu transition
	if counters.trans != -1 then
		local x = (30-counters.trans)/30 * 256
		rectfill(x-128, 0, x, 128, 0)
	end

	-- DEBUG: CPU and Mem usage
	--[[]]
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

-- Control code prefix for selected menu item
function menu_pre(idx)
	return menu_idx==idx and "\f7\#0" or "\f0"
end
