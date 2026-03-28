-- Projectiles are weapons which hone in on enemies
proj_parent = class:new({
	size=4,
})

-- Create a projectile which moves towards a parent enemy
function create_proj(start_x, start_y, type)
	local proj = {}
	
	if type==0 then
		return proj_parent:new({
			x=start_x, y=start_y, collide_r=6,
			draw = function(_ENV)
				--circfill(x, y, size, 0)
				spr(17, x, y)
			end,
			update = function(self, parent_enemy)
				-- Get direction to parent
				dir = atan2(parent_enemy.x-self.x, parent_enemy.y-self.y)

				-- Move in that direction
				self.x += cos(dir)
				self.y += sin(dir)

				-- Destroy self if colliding with enemy
				-- TODO: decrease parent's health
				if (collide_2(self, parent_enemy)) del(parent_enemy.projs, self)
			end,
		})
	end
end

-- Items are power-ups added to the player's collection on every level up
item_parent = class:new({
	-- Spawn this item every N frames
	n = 60, type=0,
	cooldown = function(_ENV)
		-- If cooldown is up
		if global.global_cnt % n == 0 then
			local near_e = 0
			local near_d = 10000
			for e in all(global.enemies) do
				-- Find enemy which is closest
				local dist = sqrt((global.plyr.x-e.x)^2, (global.plyr.y-e.y)^2)
				if dist < near_d then
					near_e = e
				end
			end
			if near_e != 0 then
				printh("spawned proj!")
				-- Add a projectile to hone in on that enemy
				add(near_e.projs, create_proj(global.plyr.x, global.plyr.y, type))
			end
		end
	end
})

-- Create an item, which spawns projectiles on a cooldown
function create_item(type)
	local item = item_parent:new({type=0})
	if (type == 0) item.n = 60

	return item
end