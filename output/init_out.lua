function _init()
	printh("**********************")
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


	end_screen = false

	--[[]]
	
	menu = 2
	init_game()

end

function init_game()
	control_menu = false
	p = create_player()
	items = {}
	projs = {}
	

	add(items, create_item(0))
end