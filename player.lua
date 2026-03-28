-- TODO: diagonal shit
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

	move = function(_ENV)
		local btns = 0
		newx = x
		newy = y
	
		if btn(0) then
			btns += 1
			newx -= 1
		end
		if btn(1) then
			btns += 1
			newx += 1
		end
		if btn(2) then
			btns += 1
			newy -= 1
		end
		if btn(3) then
			btns += 1
			newy += 1
		end

		-- normalise diagonals
		if btns >= 2 then
			newx = newx * 0.7
			newy = newy * 0.7
		end

		-- make player move
		if btns > 0 then
			x = flr(newx)
			y = flr(newy)
		end
	end,

	draw= function (_ENV)
        spr(1, x-4, y-4)
    end
})

plyr = playerClass:new({})
