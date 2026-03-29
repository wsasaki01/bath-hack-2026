function _init()
	printh("**********************")
	-- colour pallete swapping
	poke(0x5f2e,1)
	pal({[0]=7,6,0,-4,15,4,-12,-16,14,8,-8,-15,-9,-6,-5,-13},1)
	-- transparency swapping
	palt(0, false)
	palt(3, true) -- bright blue as transparent (for now)

	-- Global counter, increments every frame
	global_cnt = 0

	-- Screen shaker
	sh_str = 0

	-- Block all inputs (used during transitions, etc.)
	block = false

	-- See README for counter info
    counters = {}
    cname = split"trans,intro,enemy_respawn"
    for c in all(cname) do
        counters[c] = -1
    end

	-- Which part of the game are you in?
	-- 0(title) 1(character select) 2(intro cutscene) 3(game)
	menu = 0

	-- Is the player currently controlling the menu?
	control_menu = false
	vertical = true

	-- Data for title screen
	people = {}
	for i=1,30 do
		add(people, {x=rnd(100)-15,y=70+rnd(15),r=8+rnd(6)})
	end
	vape = {}
	pub_lights = {}
	for i=1,10 do
		add(pub_lights, {x=rnd(110)+10, y=rnd(30)+40, r=rnd(10), c=rnd(1)<0.5 and 12 or 13})
	end
	black_tly=31 black_tlyt=31
	black_tlh=3 black_tlht=3
	start_tly=12 start_tlyt=12

	-- Main menu selected option index
	menu_idx = 1
	menu_idx_min = 1	-- Minimum and maximum indices
	menu_idx_max = 2	-- Changes depending on which menu is being used

	-- Is the "end" screen being shown on top of gameplay?
	end_screen = false

	--[[
	]]
	-- DEBUG: Launch to game
	menu = 3
	init_game()

	--[[
	-- DEBUG: Launch to intro cutscene
	menu = 2
	counters.intro_cnt = 5
	]]
end

function init_game()
	music(0)

	-- Disable menu
	control_menu = false

	-- Setup menu for end screen
	menu_idx_min = 1
	menu_idx_max = 2

	time = 0

	-- Create player
	player_setup()
	plyr = plyr2:new()

	-- Setup enemies
	enemies_setup()
	enemy_limit = 10
	enemy_respawn_gap = 20

	-- Add a new item to roster
	items = {}
	add(items, create_item("proj", 8))
	item_data[8].equipped = true

	screen_list = {}	-- Screen effects
	screen_damage_mtrx = {}
	for i=1,16 do
		local row={}
		for j=1,16 do
			add(row, 0)
		end
		add(screen_damage_mtrx, row)
	end
	add(items, create_item("screen", 9))

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
		desc="eGG YOUR\nOPPONENTS!",
		sprx=8, spry=32, spr=65
	},
	{
		name="cs stench", id=3,equipped=false,
		desc="eVER HEARD OF\nDEODORANT??",
		sprx=0, spry=48, spr=96
	},
	{
		name="camera flash", id=4,equipped=false,
		desc="fLASHBANG WITH\nPHOTOGRAPHY!",
		sprx=8, spry=48, spr=97
	},
	{
		name="cursor", id=5,equipped=false,
		desc="cs STUDENTS RISE\nUP!!!!!!",
		sprx=16, spry=48, spr=98
	},
	{
		name="pencil", id=6,equipped=false,
		desc="yOUR TRUSTY EXAM\nPENCIL",
		sprx=16, spry=32, spr=98
	},
	{
		name="volleyball", id=7,equipped=false,
		desc="bOUNCY BOUNCE\nBOUNCE",
		sprx=24, spry=32, spr=67
	},
	{
		name="frisbee", id=8,equipped=false,
		desc="fEELING\nULTIMATE !!",
		sprx=40, spry=32, spr=69
	},
	{
		name="wrench", id=9,equipped=false,
		desc="eNGINEERING\nNOW IS YOUR TIME",
		sprx=48, spry=32, spr=86
	},
}