get_dir_from_tan = function(tan) 
	if tan >= 0.125 and tan <= 0.375 then return 1 end -- up
	if tan >= 0.625 and tan <= 0.875 then return 2 end -- down
	if tan < 0.625 and tan > 0.375 then return 3 end -- left
	return 4 -- right
end

playerClass = class:new({
	x = 64,
	y = 64,

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
	
	hp = 100,
	xp = 0,
	iframe = -1, -- frames invincible from dmg

	spd = 1, -- player movement speed (should be > enemy speed)
	def = 1, -- how fast hp decreases
	str = 1, -- raw dmg multiplier
	luck = 1, -- i would love luck mechanics

	atk = 10, -- raw dmg
	atkspd = 1,

	update_hp = function(self, dmg)
		if self.iframe < 0 and dmg > 0 then
			self.hp -= dmg * self.def
			self.iframe = 3
		end
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
			x+= cos(dir) * spd
			y+= sin(dir) * spd

			idle = false
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
		if anim_i == 4 then 
			a = anims[3]
			spr(a[anim_frame], x-8, y-8, 2, 2, true) -- flip x if facing right (check if adjusted coords still work)
		else
			a = anims[anim_i]
        	spr(a[anim_frame], x-8, y-8, 2, 2) -- drawing so bounding box is centred
		end
    end,
})

plyr = playerClass:new({})
