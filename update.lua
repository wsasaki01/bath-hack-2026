function _update()
	for enemy in all(enemies) do
        enemy:update()
    end
	
	global_cnt += 1
	if (global_cnt > 36000) global_cnt = 0

    -- Decrement all counters
    for n in all(cname) do
        if (counters[n]!= -1) counters[n]-=1
    end

	-- Title Screen
	if menu==1 then
		if btnp(2) and menu_idx != 1 then
			menu_idx -= 1
		elseif btnp(3) and menu_idx != 2 then
			menu_idx += 1
		end

		if btnp(4) then
			if (menu_idx==1) menu=2 
		end
	end
end