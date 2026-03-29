playerClass = class:new({
	x = 64,
	y = 64,
	collide_r = 6,
	clr = 11, -- colour of sprite
	dir = 0,
	xp = 0,
	level = 1,
	hp = 100,
	iframe = -1, -- frames invincible from dmg

	spd = 1, -- player movement speed (should be > enemy speed)
	def = 1, -- how fast hp decreases
	str = 1, -- raw dmg multiplier
	luck = 1, -- i would love luck mechanics

	atk = 10, -- raw dmg
	atkspd = 1,
	
	-- Score is changed by enemies - check it on every frame
	score_update = function(_ENV)
		-- 100 XP to level up
		if xp>100 then
			level += 1
			xp = level % 100

			-- Select
			global.selecting_item = true
			global.pause = true
			global.control_menu = true
			global.menu_idx_min = 1
			global.menu_idx_max = 3
			global.random_items = {}
			local picks={}
			for i=1,#item_data do
				if (not item_data[i].equipped) add(picks, i)
			end
			for i=1,3 do
				local idx = flr(rnd(#picks))+1
				add(global.random_items, item_data[picks[idx]])
				del(picks, picks[idx])
			end
		end
	end,
      
	update = function(_ENV)
		if iframe >= 0 then iframe -= 1 end
        
		local hor,ver=0,0
		if btn(0) then hor -= 1 end
		if btn(1) then hor += 1 end
		if btn(2) then ver -= 1 end
		if btn(3) then ver += 1 end

		dir=atan2(hor, ver)
		if hor!=0 or ver!=0 then
			x+= cos(dir) * spd
			y+= sin(dir) * spd
		end
	end,

	update_hp = function(self, dmg)
		if self.iframe < 0 and dmg > 0 then
			self.hp -= dmg * self.def
			self.iframe = 3
		end
	end,

	draw = function (_ENV)
        spr(1, x-4, y-4)
		circ(x, y, collide_r, 8)
    end,
})

plyr = playerClass:new({})
