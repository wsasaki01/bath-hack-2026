function _init()
	printh("**********************")
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

	--[[]]
	-- DEBUG: Launch to game
	menu = 2
	init_game()

end

function init_game()
	p = create_player()
	items = {}
	projs = {}
	-- Add a new item to roster
	add(items, create_item(0))
end