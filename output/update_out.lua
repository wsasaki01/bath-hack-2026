function _update()
	global_cnt += 1
	if (global_cnt > 36000) global_cnt = 0

    
    for n in all(cname) do
        if (counters[n]!= -1) counters[n]-=1
    end

	block = counters.trans_cnt != -1

	
	if menu==1 then
		if not block then
			
			if btnp(2) and menu_idx != 1 then
				menu_idx -= 1
			elseif btnp(3) and menu_idx != 2 then
				menu_idx += 1
			end

			if btnp(4) then 
				if (menu_idx==1) counters.trans_cnt = 30
			end
		end
	
	elseif menu==2 then
		
		for pr in all(projs) do
			pr:update()
		end
	end

	
	
	if counters.trans_cnt == 15 then
		
		if (menu==1) menu=2 init_game()
	end
end


function collide(x1,y1,w1,h1,x2,y2,w2,h2)
 return abs(x2+w2/2-x1-w1/2)<=w1/2+w2/2 and abs(y2+h2/2-y1-h1/2)<=h1/2+h2/2
end