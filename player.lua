-- TODO: diagonal shit
playerClass = class:new({
	x = 64,
	y = 64,
	h = 100,
	clr = 11,
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
