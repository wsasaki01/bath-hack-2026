playerClass = class:new({
	x = 64,
	y = 64,
	h = 100,
	clr = 11,
	dir = 0,
	xp = 0,
	level = 1,
	score_update = function(_ENV)
		if xp>9 then
			level += 1
			xp = level % 100
			global.selecting_item = true
			global.pause = true
			global.control_menu = true
			global.menu_idx_min = 1
			global.menu_idx_max = 3
		end
	end,
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
