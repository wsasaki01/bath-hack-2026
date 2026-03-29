function _draw()
	-- Draw background
	cls(0)
	
	-- Title Screen and character selection
	if menu==0 or menu==1 then
		cls(11)	-- Sky

		function star(x,y,r)
			line(x-r,y,x+r,y,0)
			line(x,y-r,x,y+y,0)
		end
		star(30,4,4)	-- Stars
		star(60,7,5)
		star(95,2,3)
		star(110,3,2)

		rectfill(0,31,128,128,0) -- Inside
		fillp(▒)
		for p in all(pub_lights) do
			circfill(p.x,p.y+sin((global_cnt+p.r)/100)*5,p.r+10,12,p.c)
		end
		fillp()

		rectfill(0,10,128,30,4)						-- Title banner
		fillp(▒)
		rrectfill(6,9,20,10,3,3)					-- Neon lighting
		rrectfill(6,17,78,15,3,3)
		fillp()
		print("\^o3ffuni", 10, 12, 11)				-- Uni
		print("\^t\^w\^o3ffsurvivors", 10, 19)		-- Survivors


		rectfill(0,black_tly,128,black_tly+black_tlh,2)	-- Top bezel
		rectfill(0,45,128,48,2)		-- Middle bezel
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

		-- Wetherfork bannisters
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
			ovalfill(i+46,120,i+54,124)			-- Post Shadow
			fillp()
			rectfill(i+48,88,i+52,122,2)		-- Post
		end

		-- Press O to start
		rrectfill(87,start_tly,38,17,2,0)
		print("🅾️/z",97,start_tly+3,2)
		print("TO START!",89,start_tly+8,2)

		--print(menu_pre(1).."start game", 20, 60)
		--print(menu_pre(2).."second thing idk", 20, 70)

	-- Intro
	elseif menu==2 then
		local ic = counters.intro
		cls(0)
		rect(9,40,117,72,2)	-- outline
		local j=0
		local days={"mon", "tue", "wed", "thu", "fri", "sat"}
		for i=13,119,18 do
			j+=1
			if j%2==0 then
				rectfill(i-3,41,i+13,71,1)
			end
			if j<=3 then
				sspr(0,24,8,8,i-3,56,16,16)
			end
			print(days[j], i, 44,2)
		end
		line(9,52,117,52,2)

		top_line1 = "my friends are celebrating"
		top_line2 = "the end of exam season..."

		print(sub(top_line1,0,max(360-ic,0)),12,13,2)
		if (ic<335) print(sub(top_line2,0,335-ic),13,20,2)

		if (ic<295) sspr(8,8,8,8,65,54,16,16)
		if (ic==260) sh_str=0.5
		if (ic<260) shake(0,0) print("exam",83,60,9)

		if ic<210 then
			print("but i still have an exam",19+rnd(2),90+rnd(2),2)
			print("tomorrow!!!!!!!",32+rnd(2),100+rnd(2))
		end

		if ic<140 then
			fillp(ic<135 and █ or ▒)
			rectfill(0,0,128,128,0)
			fillp()
		end

		if (ic<110) print(sub("i must not get",0,110-ic),30,55,2)
		if (ic<85) print(sub("drunk tonight...",0,85-ic),35,62)

		if ic<20 then
			fillp(ic<5 and █ or ▒)
			rectfill(0,0,128,128,0)
			fillp()
		end

	-- Game
	elseif menu==3 then
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

		-- DEBUG: screen damage matrix
		--[[
		for i=1,16 do
			for j=1,16 do
				if (screen_damage_mtrx[i][j] != 0) print(screen_damage_mtrx[i][j],i*8-5,j*8-6,4,2)
			end
		end
		]]
      
		-- debug display player health
		print("hp: "..plyr.hp, 7, 120, 4)
		--print("f: "..plyr.anim_frame, 7, 110, 4)
		--print("dir: "..plyr.anim_i.." .. "..plyr.dir, 7, 120, 4)
		--print(plyr.tick, 80, 120, 12)
		print(total_dmg, 90, 120, 8)
		print("i "..plyr.iframe, 100, 120, 4)

	end

	printh(menu)

	-- Menu transition
	if counters.trans != -1 then
		if menu==1 or (menu==2 and counters.trans<=15) then
			circfill(97,60,(30-counters.trans)/27*200,0)
		else
			printh("drawing")
			local x = (30-counters.trans)/30 * 256
			rectfill(x-128, 0, x, 128, 2)
		end
	end

	-- DEBUG: CPU and Mem usage
	--[[
	debugs = {
		"cpu "..tostr(flr(stat(1)*100)).."%",
		"mem "..tostr(stat(0)/1024).."MB",
		counters.intro_cnt
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
