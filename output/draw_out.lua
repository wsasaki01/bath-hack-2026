function _draw()
	
	cls(7)

	
	if menu==1 then
		print("bh26 game !!!!\n", 20, 50, 0)
		print((menu_idx==1 and "\f7\#0" or "").."start game", 20, 60, 0)
		print((menu_idx==2 and "\f7\#0" or "").."second thing idk", 20, 70, 0)

	
	elseif menu==2 then
		
		camera(p.x-60,p.y-60)

		
		map(0,0,0,0,8,8)

		
		for pr in all(projs) do
			pr:draw()
		end

		p:draw()
	end

	camera()

	
	if counters.trans_cnt != -1 then
		local x = (30-counters.trans_cnt)/30 * 256
		rectfill(x-128, 0, x, 128, 0)
	end

	
	print("\#0cpu "..tostr(flr(stat(1)*100)).."%",1,1,7)
	print("\#0mem "..tostr(stat(0)/1024).."MB")
	print("\#0"..tostr(#projs).." projs")
end