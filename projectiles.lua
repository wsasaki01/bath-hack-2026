-- Projectiles are weapons which hone in on enemies
proj_parent = class:new({
	collide_r=6, speed=1,
	dir=0, size=4,
})

-- Create a projectile which moves towards a parent enemy
function create_proj(start_x, start_y, type, start_dir)
	local proj = {}

	if type==0 then
		proj = proj_parent:new({
			x=start_x, y=start_y,
			draw = function(_ENV)
				spr(17, x, y)
			end,
			update = function(self, parent_enemy)
				-- Get direction to parent
				self.dir = atan2(parent_enemy.x-self.x, parent_enemy.y-self.y)

				-- Move in that direction
				self.x += cos(self.dir) * self.speed
				self.y += sin(self.dir) * self.speed

				-- Destroy self if colliding with enemy
				-- TODO: decrease parent's health
				if (collide_2(self, parent_enemy)) del(parent_enemy.projs, self)
			end,
		})
	elseif type==1 then
		proj = proj_parent:new({
			dir=start_dir,
			alive_cnt=0,
			draw = function(_ENV)
				spr(17, x, y)
			end,
			update = function(self, parent_enemy)
				self.alive_cnt += 1

				-- Get direction to parent
				local d = atan2(parent_enemy.x-self.x, parent_enemy.y-self.y)
				if self.alive_cnt < 30 then
					local diff = d - self.dir
					if diff < 0.5 then	self.dir += diff * 0.05
					else				self.dir -= (1-diff) * 0.05
					end
				else
					self.dir = d
				end

				-- Move in that direction
				self.x += cos(self.dir) * self.speed
				self.y += sin(self.dir) * self.speed

				-- Destroy self if colliding with enemy
				-- TODO: decrease parent's health
				if (collide_2(self, parent_enemy)) del(parent_enemy.projs, self)
			end,
		})
	end

	proj.x=start_x
	proj.y=start_y

	return proj
end

-- Items are power-ups added to the player's collection on every level up
item_parent = class:new({
	-- Spawn this item every N frames
	n = 60, type=0,
	cooldown = function(_ENV)
		-- If cooldown is up
		if global.global_cnt % n == 0 then
			local px,py = global.plyr.x, global.plyr.y
			local near_e = 0
			local near_d = 10000
			for e in all(global.enemies) do
				-- Find enemy which is closest
				local dist = sqrt((px-e.x)^2, (py-e.y)^2)
				if dist < near_d then
					near_e = e
				end
			end
			if near_e != 0 then
				local proj_list = {}

				if type==0 then
					add(proj_list, create_proj(px, py, 0))
				elseif type==1 then
					for i=-1,1 do
						add(proj_list, create_proj(px, py, 1, global.plyr.dir+i*0.5))
					end
				end

				-- Add a projectile to hone in on that enemy
				for p in all(proj_list) do
					add(near_e.projs, p)
				end
			end
		end
	end
})

-- Create an item, which spawns projectiles on a cooldown
function create_item(type)
	local item = item_parent:new({type=type})
	if (type == 0) item.n = 60

	return item
end