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
    cname = split"trans_cnt"
    for c in all(cname) do
        counters[c] = -1
    end

	-- Which part of the game are you in?
	-- 1(main menu) 2(game)
	menu = 1

	-- Is the player currently controlling the menu?
	control_menu = true

	-- Random people data for title screen
	people = {}
	for i=1,30 do
		add(people, {x=rnd(100)-15,y=70+rnd(15),r=8+rnd(6)})
	end

	vape = {}

	-- Main menu selected option index
	menu_idx = 1
	menu_idx_min = 1	-- Minimum and maximum indices
	menu_idx_max = 2	-- Changes depending on which menu is being used

	-- Is the "end" screen being shown on top of gameplay?
	end_screen = false

	--[[
	-- DEBUG: Launch to game
	menu = 2
	init_game()
	]]
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
	types = {wine, beer, ginger_beer}

	-- Spawn (for now) 2 enemies
	for i=1,1 do 
		e_type = 1 + flr(rnd(3))

		-- enemies start close to any corner of the screen
		-- maximum distance = how far from corners of screen
		maxD = 20 
		eX = maxD + flr(rnd(128))
		eY = maxD + flr(rnd(128))
		printh("eX: "..eX)
		printh("eY: "..eY)

		add(enemies, types[e_type]:new{
			x = eX,
			y = eY,
		})
	end

	-- Add a new item to roster
	items = {}
	add(items, create_item(1))
end