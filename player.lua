-- player class placeholder - can replace
playerClass = class:new({
	x = 64,
	y = 64,
	h = 100,
	clr = 11,
	draw= function (_ENV)
        circfill(
            x,
            y,
            1,
            clr
        )
    end
})

plyr = playerClass:new({})