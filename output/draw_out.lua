function _draw()
	
	cls(7)

	
	if menu==1 then
		print("bh26 game !!!!\n", 20, 50, 0)
		print(menu_pre(1).."start game", 20, 60)
		print(menu_pre(2).."second thing idk", 20, 70)

	
	elseif menu==2 then
		
		camera(p.x-60,p.y-60)

		
		map(0,0,0,0,8,8)

		p:draw()

		for e in all(enemies) do
			spr(2, e.x, e.y)
			e:draw_projs()
		end

		
		camera()

		if end_screen then
			rectfill(40,40,100,100,5)
			print("end!", 60, 50, 0)
			print(menu_pre(1).."replay", 45, 60)
			print(menu_pre(2).."back to title")
		end

		local secs = time
		local mins = flr(time / 60)
		local nice_secs = time % 60
		print("\#0"..mins..":"..(nice_secs<10 and "0" or "")..secs, 100,0,7)
	end


	
	if counters.trans_cnt != -1 then
		local x = (30-counters.trans_cnt)/30 * 256
		rectfill(x-128, 0, x, 128, 0)
	end

	
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

function menu_pre(idx)
	return menu_idx==idx and "\f7\#0" or "\f0"
end
