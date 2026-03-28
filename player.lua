playerClass = class:new({
	x = 64,
	y = 64,
	collide_r = 6,
	clr = 11, -- colour of sprite
	dir = 0,
	
	hp = 100,
	xp = 0,
	iframe = -1, -- frames invincible from dmg

	spd = 1, -- player movement speed (should be > enemy speed)
	def = 1, -- how fast hp decreases
	str = 1, -- raw dmg multiplier
	luck = 1, -- i would love luck mechanics

	atk = 10, -- raw dmg
	atkspd = 1,
	
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
