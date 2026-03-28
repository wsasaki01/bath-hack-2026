playerClass = class:new({
	x = 64,
	y = 64,
	clr = 11, -- colour of sprite
	
	aabb = {
		{x, y, 1},         -- top left, colour
		{x + 8, y, 1},     -- top right
		{x, y + 8, 1},     -- bottom left
		{x + 8, y + 8, 1}, -- bottom right
    },

	hp = 100,
	xp = 0,
	iframe = -1, -- frames invincible from dmg

	spd = 1, -- player movement speed
	def = 1, -- how fast hp decreases
	str = 1, -- raw dmg multiplier
	luck = 1, -- i would love luck mechanics

	atk = 10, -- raw dmg
	atkspd = 1,

	losehp = function(self, dmg)
		if self.iframe < 0 then
			-- lose health based on base defense stat
			self.hp -= (dmg * def)
			self.iframe = 3 
		else
			self.iframe -= 1
		end
	end,

	dir = 0,
	move = function(_ENV)
		local hor,ver=0,0
		if btn(0) then hor -= 1 end
		if btn(1) then hor += 1 end
		if btn(2) then ver -= 1 end
		if btn(3) then ver += 1 end

		dir=atan2(hor, ver)
		if hor!=0 or ver!=0 then
			x+=cos(dir)
			y+=sin(dir)
		end
	end,
	draw = function (_ENV)
        spr(1, x-4, y-4)
    end
})

plyr = playerClass:new({})
