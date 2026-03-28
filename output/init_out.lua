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

	p = create_player()

	enemies = {}
	add(enemies, {
		x=60,y=60, projs={},
		update_projs=function(self)
			for p in all(self.projs) do
				p:update(self.x+4, self.y+4)
			end
		end,
		draw_projs=function(self)
			for p in all(self.projs) do
				p:draw()
			end
		end
	})

	
	items = {}
	add(items, create_item(0))
end