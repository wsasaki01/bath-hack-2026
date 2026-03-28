function _init()
	printh("**********************")

    
	enemies = {}
	types = {wine, beer, gingerBeer}

	for i=1,2 do 
		eType = 1 + flr(rnd(3))

		
		
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

	
	block = false

	
    counters = {}
    cname = split"trans_cnt"
    for c in all(cname) do
        counters[c] = -1
    end

	
	
	menu = 1

	
	control_menu = true

	
	menu_idx = 1
	menu_idx_min = 1	
	menu_idx_max = 2	

	
	end_screen = false

	--[[]]
	
	menu = 2
	init_game()

end

function init_game()
	
	control_menu = false

	
	menu_idx_min = 1
	menu_idx_max = 2

	
	p = playerClass:new()

	
	
	enemies = {}
	add(enemies, {
		x=60,y=60,collide_r=6,
		projs={},
		
	})

	
	items = {}
	add(items, create_item(0))
end