function _init()
	global_cnt = 0

	
	block = false

	
    counters = {}
    cname = split"trans_cnt"
    for c in all(cname) do
        counters[c] = -1
    end

	
	
	menu = 1

	
	menu_idx = 1

	
	menu = 2
	init_game()

end

function init_game()
	projs = {}
	add(projs, create_proj(10, 50, 0))
end