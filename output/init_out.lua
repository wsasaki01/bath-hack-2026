function _init()
    
	enemiesSpr = {}
	types = {wine, beer, gingerBeer}

	for i=1,2 do 
		eType = 1 + flr(rnd(3))

		
		
		maxD = 20 
		eX = maxD + flr(rnd(128))
		eY = maxD + flr(rnd(128))
		printh("eX: "..eX)
		printh("eY: "..eY)

		add(enemiesSpr, types[eType]:new{
			x = eX,
			y = eY,
		})
	end


	global_cnt = 0

	
    counters = {}
    cname = split"trans_cnt"
    for c in all(cname) do
        counters[c] = -1
    end

	trans = 0

	
	
	menu = 1

	
	menu_idx = 1

end