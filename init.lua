function _init()
	printh("**********************")
	
	poke(0x5f2e,1)
	pal({[0]=7,6,0,-4,15,4,-12,-16,14,8,-8,-15,-9,-6,-5,-13},1)

	-- Global counter, increments every frame
	global_cnt = 0

	-- Block all inputs (used during transitions, etc.)
	block = false

	-- See README for counter info
    counters = {}
    cname = split"trans,enemy_respawn"
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
	plyr = playerClass:new()

	-- Setup enemies
	enemies_setup()
	enemy_limit = 15
	enemy_respawn_gap = 20

	-- Add a new item to roster
	items = {}
	add(items, create_item(1))
	item_data[1].equipped = true

	-- Selecting an item on level up
	selecting_item = false
	random_items = {}

	-- Pause while selecting item
	pause = false
end

item_data = {
	{
		name="dart", id=1, equipped=false,
		desc="hOMES IN ON\nNEARBY ENEMIES.",
		sprx=0, spry=32, spr=64
	},
	{
		name="egg", id=2,equipped=false,
		desc="eGG YOUR\nOPPONENTS!.",
		sprx=8, spry=32, spr=65
	},
	{
		name="camera flash", id=3,equipped=false,
		desc="fLASHBANG WITH A\nSURPRISE SELFIE!",
		sprx=16, spry=32, spr=66
	},
}