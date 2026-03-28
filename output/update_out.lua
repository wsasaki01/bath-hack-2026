function _update()
	global_cnt += 1
	if (global_cnt > 36000) global_cnt = 0

    
    for n in all(cname) do
        if (counters[n]!= -1) counters[n]-=1
    end

	
	if menu==1 then
		if btnp(2) and menu_idx != 1 then
			menu_idx -= 1
		elseif btnp(3) and menu_idx != 2 then
			menu_idx += 1
		end

		if btnp(4) then
			if (menu_idx==1) counters.trans_cnt = 30
		end
	end

	if counters.trans_cnt == 15 then
		if (menu==1) menu=2
	end
end