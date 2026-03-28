function _init()
    -- all enemies
	enemies = {}
	types = {wine, beer, gingerBeer}

	for i=1,2 do 
		eType = 1 + flr(rnd(3))

		-- enemies start close to any corner of the screen
		-- maximum distance = how far from corners of screen
		maxD = 20 
		eX = maxD + flr(rnd(128))
		eY = maxD + flr(rnd(128))
		printh("eX: "..eX)
		printh("eY: "..eY)

		add(enemies, types[eType]:new{
			x = eX,
			y = eY,
		})
	end


	global_cnt = 0

	-- See README for counter 
    counters = {}
    cname = split"trans_cnt"
    for c in all(cname) do
        counters[c] = -1
    end

	trans = 0

	-- Which part of the game are you in?
	-- 1(main menu) 2(game)
	menu = 1

	-- Main menu selected option index
	menu_idx = 1

end