function _init()
	global_cnt = 0

	-- Block all inputs (used during transitions, etc.)
	block = false

	-- See README for counter 
    counters = {}
    cname = split"trans_cnt"
    for c in all(cname) do
        counters[c] = -1
    end

	-- Which part of the game are you in?
	-- 1(main menu) 2(game)
	menu = 1

	-- Main menu selected option index
	menu_idx = 1

end

function init_game()
	projs = {}
	add(projs, create_proj(10, 50, 0))
end