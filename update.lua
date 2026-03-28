function _update()	
	-- Increment and reset global counter at limit
	global_cnt += 1
	if (global_cnt > 30000) global_cnt = 0

    -- Decrement all counters
    for n in all(cname) do
        if (counters[n]!= -1) counters[n]-=1
    end

	-- If in transition, block all player input
	block = counters.trans_cnt != -1

	-- If menu is active and not blocked,
	if control_menu and not block then
		-- Moving "cursor"
		if btnp(2) and menu_idx != menu_idx_min then
			menu_idx -= 1
		elseif btnp(3) and menu_idx != menu_idx_max then
			menu_idx += 1
		end

		-- Selecting options
		if btnp(4) then
			-- Begin transition
			-- Needs to be more complex if there are any items added that don't transition
			counters.trans_cnt = 30
		end
	end

	-- Title Screen
	if menu==1 then
		-- Generate vape clouds at intervals
		if global_cnt % 150 == 0 then
			local main_x=rnd(75)
			for i=1,4 do
				add(vape, {
					x=main_x+rnd(10), y=100+rnd(10), a=10+rnd(2),
					r=5+rnd(5), cnt=0
				})
			end
		end

		for v in all(vape) do
			v.x += 0.5
			v.a *= 0.86
			v.y -= v.a+rnd(0.2)
			v.cnt += 1
			if (v.x>150) del(vape, v)
		end
	-- Game
	elseif menu==2 then
		-- Game end screen
		if end_screen then
			-- Placeholder
			q=1

		-- Normal gameplay
		else
			-- Record current time
			time = flr(t())

			-- Stop game after time is up
			if time > 300 then
				end_screen = true		-- Enable the end screen
				control_menu = true		-- Enable control of menus
				menu_idx = 1			-- Set the first item to be selected
			end

			-- Cooldown all items, and shoot if cooldown is up
			for i in all(items) do
				i:cooldown()
			end

			-- Move all projectiles towards enemies
			for e in all(enemies) do
				e:update()			-- Move enemy and destroy if dead
				e:update_projs()	-- Move all projectiles honed on this enemy
			end

			-- Player movement
			plyr:move()
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

-- Circle collision
-- Pass in two objects with x, y, and collide_r
function collide_2(a, b)
    return ((a.x - b.x)^2 + (a.y - b.y)^2) <= a.collide_r + b.collide_r
end
