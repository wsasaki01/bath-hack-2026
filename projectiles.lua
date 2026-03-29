-- What each screen instance needs
proj_parent = class:new({
	collide_r=6, speed=1,
	dir=0, size=4,
})

-- Create a single projectile which moves towards a parent enemy
function create_proj(start_x, start_y, type, start_dir)
	local proj = {}

	-- Types 1 and 2 are the same, but with slightly different direction management
	if type<=2 then
		proj = proj_parent:new({
			x=start_x, y=start_y, damage=10, dir=0,
			
			update = function(self, parent_enemy)
				-- Move in that direction
				self.x += cos(self.dir) * self.speed
				self.y += sin(self.dir) * self.speed

				--printh("x+="..cos(self.dir) * self.speed)
				--printh("y+="..sin(self.dir) * self.speed)

				-- Destroy self if colliding with enemy
				if collide_2(self, parent_enemy) then
					del(parent_enemy.projs, self)			-- Destroy self
					parent_enemy:take_damage(self.damage)	-- Decrease enemy's health on hit
				end
			end,

			-- Get direction to parent
			update_dir = function(self, tx, ty)
				self.dir = atan2(tx-self.x, ty-self.y)
			end,

			draw = function(_ENV)
				spr(80, x-4, y-4, 1, 1, not (dir<0.25 or 0.75<dir))
			end,
		})
	
		if type==2 then
			proj.dir = start_dir	-- Direction needs to change slowly over time
			proj.alive_cnt = 0		-- New direction function only used for first 30 frames
			proj.update_dir = function(self, tx, ty)
				self.alive_cnt += 1
				local d = atan2(tx-self.x, ty-self.y)
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

			proj.draw = function(_ENV)
				spr(81, x-4, y-4)
			end
		end
	end

	-- All projectiles start from player character
	proj.x=start_x
	proj.y=start_y

	return proj
end

-- What each screen instance needs
screen_parent = class:new({
	n = 60, id=0, data={}
})

-- Create a single area effect
function create_screen(id)
	local screen = {}

	-- ID 3: Stench
	if id==3 then
		screen = screen_parent:new({
			x=0,y=0,damage=1,rad=30,
			points={},
			
			update = function(_ENV)
				x=plyr.x
				y=plyr.y

				-- Do damage only every 10 frames
				if global.global_cnt % 10==0 then
					for p in all(points) do
						global.screen_damage_mtrx[p[1]][p[2]] += damage
					end
				end
			end,

			-- Use this to calculate the bins which need to be filled in the screen matrix
			-- ONLY needs to be run when setting a new radius
			-- Otherwise, during update(), it just uses the saved bins
			set_radius = function(_ENV, new_r)
				rad = new_r

				local cx,cy=8,8
				local sr=flr(rad/8)
				points = {}
				for i=-sr,sr do
					for j=-sr,sr do
						add(points, {cx+i,cy+j})
					end
				end
			end,

			draw = function(_ENV)
				fillp(▒)
				circfill(x,y,rad,12)
				fillp()
			end,
		})
	elseif id==4 then
		screen = screen_parent:new({
			x=0,y=0,damage=1000,
			points={}, fired_cnt=-1,
			dx1=1,dx2=1,dy1=1,dy2=1,
			
			update = function(_ENV)
				if (fired_cnt!=-1) fired_cnt-=1
				x=global.plyr.x
				y=global.plyr.y
				local pd = global.plyr.dir

				-- Fires every 20 seconds
				if global.global_cnt % 20==0 then
					fired_cnt = 10
					x1,x2=1,1
					y1,y2=1,1
					if pd < 0.25 then
						x1,x2=9,16
						y1,y2=1,8
					elseif pd < 0.5 then
						x1,x2=1,8
						y1,y2=1,8
					elseif pd < 0.75 then
						x1,x2=1,8
						y1,y2=9,16
					else
						x1,x2=9,16
						y1,y2=9,16
					end

					for i=x1,x2 do
						for j=y1,y2 do
							global.screen_damage_mtrx[i][j] += damage
						end
					end

					dx1=x1*8-8+4 dx2=x2*8-8-4
					dy1=y1*8-8+4 dy2=y2*8-8-4
				end
			end,

			draw = function(_ENV)
				if fired_cnt!=-1 then
					cx,cy=camera()
					line(dx1,dy1,dx1+5,dy1)	-- TL right
					line(dx1,dy1,dx1,dy1+5)	-- TL down

					line(dx1,dy2,dx1,dy2-5)	-- BL up
					line(dx1,dy2,dx1+5,dy2)	-- BL right

					line(dx2,dy1,dx2-5,dy1)	-- TR left
					line(dx2,dy1,dx2,dy1+5)	-- TR down

					line(dx2,dy2,dx2,dy2-5)	-- BR up
					line(dx2,dy2,dx2-5,dy2)	-- BR left
					camera(cx,cy)
				end
			end,
		})
	end

	return screen
end

-- Items are power-ups added to the player's collection on every level up
-- This object manages the spawning of a certain kind of projectile
proj_manager = class:new({
	-- Spawn this item every N frames
	type="proj", n = 60, id=0, data={},
	cooldown = function(self)
		printh(self.data.name)
		-- If cooldown is up
		if global_cnt % self.n == 0 then
			local px,py = global.plyr.x, global.plyr.y
			near_e = find_nearest_enemy(px,py)
			if near_e != 0 then
				local proj_list = {}

				if self.id==1 then
					add(proj_list, create_proj(px, py, 1))
				elseif self.id==2 then
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
	end,
})

-- This object manages the spawning of a certain kind of screen effect
screen_manager = class:new({type="screen", })

-- Find nearest enemy from centre x,y coords
function find_nearest_enemy(cx,cy)
	local near_e = 0
	local near_d = 10000
	for e in all(enemies) do
		-- Find enemy which is closest
		local dist = sqrt((cx-e.x)^2 + (cy-e.y)^2)
		if dist < near_d then
			near_e = e
			near_d = dist
		end
	end

	return near_e
end

-- Create an item (either projectile or screen type)
function create_item(type, id)

	if type=="proj" then
		local item = proj_manager:new({id=id, data=item_data[id]})
		if (id == 1) item.n = 50
		if (id == 2) item.n = 170
		return item 

	elseif type=="screen" then
		local item = screen_manager:new({id=id, data=item_data[id]})
		if id == 3 then
			i = create_screen(3)
			i:set_radius(17)
			add(screen_list, i)
		elseif id==4 then
			i = create_screen(4)
			add(screen_list, i)
		end
		return item
	end
end