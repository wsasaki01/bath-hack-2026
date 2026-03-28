-- TODO: diagonal shit
playerClass = class:new({
	x = 64,
	y = 64,
	clr = 11, -- colour of sprite

	hp = 100,
	xp = 0,

	spd = 1, -- player movement speed
	def = 1, -- how fast hp decreases
	str = 1, -- raw dmg multiplier
	luck = 1, -- i would love luck mechanics

	atk = 10, -- raw dmg
	atkspd = 1,

	move = function(_ENV)
			if btn(0) then
				x -= 1
			end
			if btn(1) then
				x += 1
			end
			if btn(2) then
				y -= 1
			end
			if btn(3) then
				y += 1
			end
		end,
	draw= function (_ENV)
        spr(1, x-4, y-4)
    end
})

plyr = playerClass:new({})
