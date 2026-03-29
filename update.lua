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

	black_tly = tend(black_tly,black_tlyt,0.30)
	black_tlh = tend(black_tlh,black_tlht,0.30)
	start_tly = tend(start_tly,start_tlyt,0.15)

	-- If menu is active and not blocked,
	if control_menu and not block then
		local inc_btn = vertical and 3 or 1
		local dec_btn = vertical and 2 or 0

		-- Moving "cursor"
		if btnp(dec_btn) and menu_idx != menu_idx_min then
			menu_idx -= 1
		elseif btnp(inc_btn) and menu_idx != menu_idx_max then
			menu_idx += 1
		end

		-- Selecting options
		if btnp(4) then
			-- Level up menu
			if menu==3 then
				if end_screen then
					menu=1
					music(-1, 300)
				else
					local item_id=random_items[menu_idx].id
					if is_in(item_id, {3,4,5}) then
						add(items, create_item("screen", item_id))
					else
						add(items, create_item("proj", item_id))
					end
					item_data[item_id].equipped = true
					selecting_item = false
					pause = false
					control_menu = false
				end
			else
				-- Begin transition
				counters.trans = 30
      		end
		end
	end

	-- Title Screen
	if menu==0 or menu==1 then
		if menu==0 and btnp(4) then
			menu=1
			counters.trans = 30
			--[[
			black_tlyt=9
			black_tlht=39
			start_tlyt=20
			control_menu = true
			vertical = false
			-- TODO: Change to number of playable characters
			menu_idx_min = 1	-- Minimum and maximum indices
			menu_idx_max = 2	-- Changes depending on which menu is being used
			]]
		end

		if menu==0 then
			-- Generate vape clouds at intervals
			if (global_cnt+120) % 190 == 0 then
				local main_x=rnd(75)
				for i=1,4 do
					add(vape, {
						x=main_x+rnd(10), y=100+rnd(10), a=10+rnd(2),
						r=5+rnd(5), cnt=0
					})
				end
			end
		end

		for v in all(vape) do
			v.x += 0.5
			v.a *= 0.86
			v.y -= v.a+rnd(0.2)
			v.cnt += 1
			if (v.x>150) del(vape, v)
		end
	-- Intro cutscene
	elseif menu==2 then
		--if (counters.intro > 300) counters.intro=5
		if (counters.intro==1) counters.trans=30
	-- Game
	elseif menu==3 then
		-- Game end screen
		if end_screen then
			-- Placeholder
			q=1
		-- Normal gameplay
		elseif not pause then
			-- DEBUG: Increase XP
			--[[
			if btnp(5) then
				plyr.xp += 10
			end
			]]

			-- Empty screen damage matrix
			for i=1,16 do
				for j=1,16 do
					screen_damage_mtrx[i][j] = 0
				end
			end

			if (#enemies != enemy_limit and counters.enemy_respawn == -1) spawn_enemy()

			-- Record current time
			time = flr(t())

			-- Stop game after time is up
			if time > 9000 then
				end_screen = true		-- Enable the end screen
				control_menu = true		-- Enable control of menus
				menu_idx = 1			-- Set the first item to be selected
				menu_idx_max = 1
				menu_idx_min = 1

			end

			-- Cooldown all items, and shoot if cooldown is up
			for i in all(items) do
				if i.type=="proj" then
					i:cooldown()
				end
			end

			-- Player movement
			plyr:update()
			plyr:score_update()

			-- Screen item updates
			for screen in all(screen_list) do
				screen:update()
			end

			-- Move all projectiles towards enemies
			total_dmg = 0 -- keeps track of all the dmg added by enemies
			for e in all(enemies) do
				total_dmg += e:update()	-- Move enemy and destroy if dead
				e:update_projs()	-- Move all projectiles honed on this enemy
			end

			plyr:update_hp(total_dmg)
		end
	end

	-- Change to different menu modes in the middle of transitions (15th frame out of 30)
	-- (when screen is fully covered by transition)
	if counters.trans == 15 then
		-- Character select -> intro cutscene
		if menu==1 then
			menu=2 counters.intro = 385
		-- Intro cutscene -> gameplay
		elseif menu==2 then
			menu=3 init_game()
		-- Gameplay -> main menu
		elseif menu==3 then
			menu=1
		end
	end
end

-- Circle collision
-- Pass in two objects with x, y, and collide_r
function collide_2(a, b)
    return ((a.x - b.x)^2 + (a.y - b.y)^2) <= a.collide_r + b.collide_r
end

function collide_3(x1, y1, r1, x2, y2, r2)
    return ((x1 - x2)^2 + (y1 - y2)^2) <= (r1 + r2)
end

function tend(x,t,r)
    local o = x+(t-x)*r
    return abs(t-o)<1 and t or o
end

function shake(cx,cy)
-- apply screen shake
 camera((cx+20-rnd(40))*sh_str, (cy+20-rnd(40))*sh_str)
 sh_str *= 0.75
 if (sh_str < 0.05) sh_str = 0
end

function is_in(a,t)
	for i=1,#t do
		if (a==t[i]) return true
	end
	return false
end