function _update()
	global_cnt += 1
	if (global_cnt > 30000) global_cnt = 0

    -- Decrement all counters
    for n in all(cname) do
        if (counters[n]!= -1) counters[n]-=1
    end

	block = counters.trans_cnt != -1

	if control_menu and not block then
		if not block then
			-- Moving "cursor"
			if btnp(2) and menu_idx != menu_idx_min then
				menu_idx -= 1
			elseif btnp(3) and menu_idx != menu_idx_max then
				menu_idx += 1
			end

			if btnp(4) then -- Selecting options
				counters.trans_cnt = 30
			end
		end
	end

	-- Title Screen
	if menu==1 then
	-- Game
	elseif menu==2 then
		if end_screen then
			q=1
		else
			time = flr(t())

			-- Stop game after time is up
			if time > 0 then
				end_screen = true
				control_menu = true
				menu_idx = 1
			end

			for i in all(items) do
				i:cooldown()
			end

			-- Projectile processing
			for pr in all(projs) do
				pr:update()
			end

			p:move()
		end
	end

	-- Change to different menu modes in the middle of transitions (15th frame out of 30)
	-- (when screen is fully covered by transition)
	if counters.trans_cnt == 15 then
		-- Main menu -> gameplay
		if (menu==1) menu=2 init_game()
		-- Gameplay -> main menu
		if (menu==2) menu=1
	end
end

-- check collision between two rectangles
function collide(x1,y1,w1,h1,x2,y2,w2,h2)
 return abs(x2+w2/2-x1-w1/2)<=w1/2+w2/2 and abs(y2+h2/2-y1-h1/2)<=h1/2+h2/2
end