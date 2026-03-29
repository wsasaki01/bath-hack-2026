get_dir_from_tan = function(tan) 
	if tan >= 0.125 and tan <= 0.375 then return 1 end -- up
	if tan >= 0.625 and tan <= 0.875 then return 2 end -- down
	if tan < 0.625 and tan > 0.375 then return 3 end -- left
	return 4 -- right
end

function player_setup()
	playerClass = class:new({
		x = 127,
		y = 127,
		clrs = {},

		collide_r = 8,
		dir = 0,
			
		anims = {
			{036, 038, 036, 040}, -- walk up
			{000, 032, 000, 034}, -- walk down
			{042, 044, 042, 046}, -- walk sideways (flip for left / right)
		},

		idle = true,
		anim_i = 1,
		anim_frame = 1,
		tick = -1, -- change to counter

		xp = 0,
		level = 1,
		xp_required=100,
		hp = 100,
		iframe = -1, -- frames invincible from dmg

		spd = 1.7, -- player movement speed (should be > enemy speed)
		def = 1, -- how fast hp decreases
		str = 1, -- raw dmg multiplier
		luck = 1, -- i would love luck mechanics

		atk = 10, -- raw dmg
		atkspd = 1,
		
		-- Score is changed by enemies - check it on every frame
		score_update = function(_ENV)
			-- 100 XP to level up
			if xp>xp_required then
				level += 1
				xp = level % 100
				xp_required *= 1.3

				global.enemy_limit *= 2
				global.enemy_respawn_gap *= 0.8

				-- Select
				global.selecting_item = true
				global.pause = true
				global.control_menu = true
				global.random_items = {}
				global.menu_idx = 1
				local picks={}
				for i=1,#item_data do
					if (not item_data[i].equipped) add(picks, i)
				end
				if #picks!=0 then
					for i=1,3 do
						local idx = flr(rnd(#picks))+1
						add(global.random_items, item_data[picks[idx]])
						del(picks, picks[idx])
					end
					global.menu_idx_min = 1
					global.menu_idx_max = #global.random_items
				else
					global.selecting_item = false
					global.pause = false
					global.control_menu = false
				end
			end
		end,

		update_hp = function(self, dmg)
			if self.iframe < 0 and dmg > 0 then
				sfx(6)
				self.hp -= dmg * self.def
				self.iframe = 3
				if self.hp<=0 then
					end_screen = true
				end
			end
		end,

		detect_sprite_collisions = function(x, y)
			cx = x / 8
			cy = y / 8
			return fget(mget(cx, cy), 1)
		end,
		
		update = function(_ENV)
			if iframe >= 0 then iframe -= 1 end
			if not idle and tick <= 0 then 
				anim_frame = anim_frame < 4 and anim_frame + 1 or 1
				tick = 4 -- 4 frames until next animation is seen
			else
				tick -= 1
			end

			local hor,ver=0,0
			if btn(0) then hor -= 1 end
			if btn(1) then hor += 1 end
			if btn(2) then ver -= 1 end
			if btn(3) then ver += 1 end
			
			dir=atan2(hor, ver)
			if hor!=0 or ver!=0 then
				_x= x+ cos(dir) * spd
				_y= y+ sin(dir) * spd

				if not detect_sprite_collisions(_x,_y) then
					x = _x
					y = _y
					idle=false
				else
					idle=true
				end

			
				if anim_i != get_dir_from_tan(dir) then -- changed direction = restart animation
					anim_i = get_dir_from_tan(dir)
					anim_frame = 1
				end
			else
				idle = true
				anim_frame = 1
			end

		end,

		draw = function (_ENV)
			for c in all(clrs) do
				pal(c[1], c[2])
			end

			if anim_i == 4 then 
				a = anims[3]
				spr(a[anim_frame], x-8, y-8, 2, 2, true) -- flip x if facing right (check if adjusted coords still work)
			else
				a = anims[anim_i]
				spr(a[anim_frame], x-8, y-8, 2, 2) -- drawing so bounding box is centred
			end
			for c in all(clrs) do
				pal(c[1], c[1])
			end

		end,
	})

	-- base player
	plyr1 = playerClass:new({
	})

	-- alt player
	plyr2 = playerClass:new({
		-- palette swaps
		clrs = {
			{13, 9},
			{10, 7},
			{14, 10},
			{6, 7}, -- LOOOL 67 67 67 67 
			{5, 7}, 
			{4, 5},
			{8, 6}
		}
	})

	-- blond player (super ugly lowk)
	plyr3 = playerClass:new({
		clrs = {
			{6, 5},
			{14, 5},
			{13, 12},
			{15, 6},
			{11, 6},
			{7, 11}
		}
	})
end