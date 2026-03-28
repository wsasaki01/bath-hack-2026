
playerClass = class:new({
	x = 64,
	y = 64,
	h = 100,
	clr = 11,
	move = function(self)
			if btn(0) then
				self.x -= 1
			end
			if btn(1) then
				self.x += 1
			end
			if btn(2) then
				self.y -= 1
			end
			if btn(3) then
				self.y += 1
			end
		end,
	draw= function (_ENV)
        spr(1, self.x-4, self.y-4)
    end
})

plyr = playerClass:new({})
