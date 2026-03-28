function _init()
	printh("**********************")

	-- all enemies
	enemies={enemy, beer, wine, gingerBeer}

	-- Global counter, increments every frame
	global_cnt = 0

	-- Block all inputs (used during transitions, etc.)
	block = false

	-- See README for counter info
    counters = {}
    cname = split"trans_cnt"
    for c in all(cname) do
        counters[c] = -1
    end

	-- Which part of the game are you in?
	-- 1(main menu) 2(game)
	menu = 1

	-- Is the player currently controlling the menu?
	control_menu = true

	-- Main menu selected option index
	menu_idx = 1
	menu_idx_min = 1	-- Minimum and maximum indices
	menu_idx_max = 2	-- Changes depending on which menu is being used

	-- Is the "end" screen being shown on top of gameplay?
	end_screen = false

	--[[]]
	-- DEBUG: Launch to game
	menu = 2
	init_game()

end

function init_game()
	-- Disable menu
	control_menu = false

	-- Setup menu for end screen
	menu_idx_min = 1
	menu_idx_max = 2

	-- Create player
	p = create_player()

	-- Setup enemies
	-- TODO: Needs to be updated with dt's stuff
	enemies = {}
	add(enemies, {
		x=60,y=60,collide_r=6,
		projs={},
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