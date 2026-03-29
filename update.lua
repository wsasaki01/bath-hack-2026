function _update()	
	-- Increment and reset global counter at limit
	global_cnt += 1
	if (global_cnt > 30000) global_cnt = 0

    -- Decrement all counters
    for n in all(cname) do
        if (counters[n]!= -1) counters[n]-=1
    end

	-- If in transition, block all player input
	block = counters.trans != -1

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
			-- Level up menu
			if menu==2 then
				add(items, create_item(random_items[menu_idx].id))
				global.selecting_item = false
				global.pause = false
				global.control_menu = false
			else
				-- Begin transition
				counters.trans = 30
			end
		end
	end

	-- Title Screen
	if menu==1 then
	-- Game
	elseif menu==2 then
		-- Game end screen
		if end_screen then
			-- Placeholder
			q=1
		-- Normal gameplay
		elseif not pause then
			-- DEBUG: Increase XP
			if btnp(5) then
				plyr.xp += 10
			end

			if #enemies != enemy_limit and counters.enemy_respawn == -1 then
				counters.enemy_respawn = enemy_respawn_gap

				-- Choose random enemy type
				e_type = 1 + flr(rnd(3))

				-- enemies start close to any corner of the screen
				-- maximum distance = how far from corners of screen
				maxD = 20
				eX = maxD + flr(rnd(128))
				eY = maxD + flr(rnd(128))
				printh("eX: "..eX)
				printh("eY: "..eY)

				add(enemies, enemy_types[e_type]:new{
					x = eX,
					y = eY,
				})
			end

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
				e:check_death()
				e:update()			-- Move enemy and destroy if dead
				e:update_projs()	-- Move all projectiles honed on this enemy
			end

			-- Player movement
			plyr:move()
			plyr:score_update()
		end
	end

	-- Change to different menu modes in the middle of transitions (15th frame out of 30)
	-- (when screen is fully covered by transition)
	if counters.trans == 15 then
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
