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

	control_menu = true

	-- Main menu selected option index
	menu_idx = 1
	menu_idx_min = 1
	menu_idx_max = 2

	end_screen = false

	--[[]]
	-- DEBUG: Launch to game
	menu = 2
	init_game()

end

function init_game()
	control_menu = false
	menu_idx_min = 1
	menu_idx_max = 2

	p = create_player()

	enemies = {}
	add(enemies, {
		x=60,y=60,col_r=6,projs={},
		update_projs=function(self)
			for p in all(self.projs) do
				p:update(self)
			end
		end,
		draw_projs=function(self)
			for p in all(self.projs) do
				p:draw()
			end
		end
	})

	-- Add a new item to roster
	items = {}
	add(items, create_item(0))
end