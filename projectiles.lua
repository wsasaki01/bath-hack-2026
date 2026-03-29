-- Projectiles are weapons which hone in on enemies
proj_parent = class:new({
	collide_r=6, speed=1,
	dir=0, size=4,
})

-- Create a projectile which moves towards a parent enemy
function create_proj(start_x, start_y, type, start_dir)
	local proj = {}

	-- Types 1 and 2 are the same, but with slightly different direction management
	if type<=2 then
		proj = proj_parent:new({
			x=start_x, y=start_y, damage=10,
			
			update = function(self, parent_enemy)
				-- Move in that direction
				self.x += cos(self.dir) * self.speed
				self.y += sin(self.dir) * self.speed

				--printh("x+="..cos(self.dir) * self.speed)
				--printh("y+="..sin(self.dir) * self.speed)

				-- Destroy self if colliding with enemy
				if collide_2(self, parent_enemy) then
					parent_enemy.health -= self.damage	-- Decrease enemy's health on hit
					del(parent_enemy.projs, self)		-- Destroy self
				end
			end,

			-- Get direction to parent
			update_dir = function(self, tx, ty)
				self.dir = atan2(tx-self.x, ty-self.y)
			end,

			draw = function(_ENV)
				spr(32, x-4, y-4)
				--line(x,y,x+cos(dir)*15,y+sin(dir)*15)
			end,
		})
	
		--[[
		if type==2 then
			proj.dir = start_dir	-- Direction needs to change slowly over time
			proj.alive_cnt = 0		-- New direction function only used for first 30 frames
			proj.update_dir = function(self, parent_enemy)
				self.alive_cnt += 1
				local d = atan2(parent_enemy.x-self.x, parent_enemy.y-self.y)
				if self.alive_cnt < 30 then
					-- SLOWLY change direction towards enemy,
					-- so bullets kinda fan out of player
					local diff = d - self.dir
					if diff < 0.5 then	self.dir += diff * 0.05
					else				self.dir -= (1-diff) * 0.05
					end
				else
					-- After 30 secs, change back to normal direction management
					self.dir = d
				end
			end
		end
		]]
	end

	-- All projectiles start from player character
	proj.x=start_x
	proj.y=start_y

	return proj
end

-- Items are power-ups added to the player's collection on every level up
item_parent = class:new({
	-- Spawn this item every N frames
	n = 60, type=0, data={},
	cooldown = function(_ENV)
		-- If cooldown is up
		if global.global_cnt % n == 0 then
			local px,py = global.plyr.x, global.plyr.y
			local near_e = 0
			local near_d = 10000
			for e in all(global.enemies) do
				-- Find enemy which is closest
				local dist = sqrt((px-e.x)^2 + (py-e.y)^2)
				if dist < near_d then
					near_e = e
					near_d = dist
				end
			end
			if near_e != 0 then
				local proj_list = {}

				if type==1 then
					add(proj_list, create_proj(px, py, 1))
				elseif type==2 then
					for i=-1,1 do
						add(proj_list, create_proj(px, py, 2, global.plyr.dir-0.5+i*0.45))
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
	local item = item_parent:new({type=type, data=item_data[type]})
	if (type == 1) item.n = 60

	return item
end