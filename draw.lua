function _draw()
	-- Draw background
	cls(7)
	
	-- Title Screen
	if menu==1 then
		cls(11)

		rectfill(0,10,128,30,4)						-- Title banner
		print("\^o3ffuni", 10, 12, 11)				-- Uni
		print("\^t\^w\^o3ffsurvivors", 10, 19)		-- Survivors

		rectfill(0,31,128,128,0) -- Inside

		rectfill(0,31,128,34,2)	-- Top bezel
		rectfill(0,45,128,48,2)	-- Middle bezel
		rectfill(80,31,83,128,2)	-- Left door bezel
		rectfill(110,31,113,128,2)	-- Right door bezel

		rectfill(0,105,128,128,4)	-- Floor
		-- Street lines
		for i=8,120,10 do
			for j=-64,192 do
				line(i+4,105,(i-30)/60*256-64,128,1)
			end
		end
		line(0,110,128,110)	-- Top horizontal grid
		line(0,120,128,120)	-- Bottom horizontal grid

		rectfill(0,105,100,128,7)	-- Floor shadow
		for i=100,111 do
			line(100,110,i,128,7)	-- Little diagonal shadow on right
		end

		-- Draw vape clouds
		for v in all(vape) do
			fillp(v.cnt<80 and ▒ or ░)
			circfill(v.x, v.y, v.r+v.cnt/200*10, 1)
			fillp()
		end

		rectfill(0,80,99,118,11)	-- People bulk
		circfill(84,78,15)			-- Right-most person (covers up the edge of bulk)
		for p in all(people) do
			-- Sin and cos with kinda random stuff to make pseudo-random movement
			circfill(p.x+sin((global_cnt+p.r*43)/100),p.y+cos((global_cnt+p.r*120)/130),p.r)
		end

		-- Draw twice (55 pixels apart)
		for i=0,55,55 do
			pset(i-1,89,3)						-- Top left dot
			pset(i-1,121,3)						-- Bottom left dot
			rectfill(i,90,i+45,120,3)			-- Banner
			pset(i+46,89,3)						-- Top right dot
			pset(i+46,121,3)					-- Bottom right dot
			print("\^uWETHERFORK",i+3,102,8)	-- Text
			circfill(i+50,88,2,2)				-- Post Top
			fillp(▒)
			ovalfill(i+46,120,i+54,124)		-- Post Shadow
			fillp()
			rectfill(i+48,88,i+52,122,2)		-- Post
		end

		--print(menu_pre(1).."start game", 20, 60)
		--print(menu_pre(2).."second thing idk", 20, 70)

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

		-- End screen
		if end_screen then
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
	--[[
	debugs = {
		"cpu "..tostr(flr(stat(1)*100)).."%",
		"mem "..tostr(stat(0)/1024).."MB",
	}

	local i=0
	for d in all(debugs) do
		print("\#0"..d,1,1+i*6,7)
		i+=1
	end
	]]
end

-- Control code prefix for selected menu item
function menu_pre(idx)
	return menu_idx==idx and "\f7\#0" or "\f0"
end
