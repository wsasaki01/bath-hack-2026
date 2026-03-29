function enemies_setup()
	enemies = {}

    -- enemy base class object
    enemy = class:new({
        name = "enemy",
        clr = -1,   -- colour
        sprt = 6,  -- sprite index

        x = -1,
        y = -1,
        collide_r = 4,  -- circle radius for projectiles

        dmg = 1,   -- strength of attack
        spd = 20,    -- speed

        projs = {}, -- projectiles currently moving towards enemy
        reward = 10,
        health = 10,
        took_dmg = false,
        dmg = 1,   -- strength of attack

        update_projs = function(self)
            for p in all(self.projs) do
                -- Make projectile move towards enemy
                p:update_dir(self.x, self.y)
                p:update(self)
            end
        end,

        draw_projs = function(_ENV)
            for p in all(projs) do
                p:draw()
            end
        end,

        check_death = function(self)
            if self.health <= 0 then
                -- TODO: Death animation
                del(enemies, self)
                plyr.xp += self.reward
                for p in all(self.projs) do 
                    near_e = find_nearest_enemy(p.x,p.y)
                    if (near_e!=0) printh("added!") add(near_e.projs, p)
                end
            end
        end,

        -- move towards player x, y
        -- Returns total damage inflicted on player
        update = function(self)
            -- comparing enemy position to current player position
            local px = global.plyr.x
            local py = global.plyr.y

            -- find direction to player
            local d = atan2(px - self.x , py - self.y)
            
            -- move by 1 unit
            self.x += cos(d) * self.spd
            self.y += sin(d) * self.spd
            
            -- if enemy at player position, health decreases
            -- replace w goated collisions later
            if self.x == px or self.y == py then global.plyr.hp -= 10 end

            -- Transform enemy coords to screen space
            -- Then div by 8 to place into one of 256 "bins" in screen_damage_matrix
            local xidx,yidx=flr((self.x-px+64)/8),flr((self.y-py+64)/8)
            -- If the enemy is on screen...
            if (1<=xidx and xidx<=16) and (1<=yidx and yidx<=16) then
                -- Decrement their health by whatever is in that bin
                self:take_damage(screen_damage_mtrx[xidx][yidx])
            end
        
            -- check for player collision
            if collide_3(self.x, self.y, self.collide_r, px, py, self.collide_r) then
                return self.dmg
            end
            return 0
        end,

        take_damage = function(self, dmg)
            if dmg!=0 then
                self.health -= dmg
                self.took_dmg = true
                self:check_death()
            end
        end,

        draw = function(_ENV)
            if took_dmg then
                rectfill(x-6,y-6,x+6,y+6,9)
                took_dmg = false
            end
            spr(sprt, x-4, y-4)
            line(x-4,y+6,x+4,y+6,8) line(x-4,y+6,x-4+health/10*8,y+6,9) -- Health bar
        end
    })

    -- enemy class entities
    -- more subclasses can be added if needed e.g. drinks, evil old men, etc
    beer = enemy:new({
        name = "beer",
        spd = 0.5,
        sprt = 23,
    })

    ginger_beer = beer:new({
        name = "ginger beer",
        clr = 4, -- TODO: try and recolour beer sprite?
    })

    wine = enemy:new({
        name = "wine",
        spd = 0.25,
        sprt = 7
    })
    
	enemy_types = {wine, beer, ginger_beer}
end

function spawn_enemy()
    counters.enemy_respawn = enemy_respawn_gap

    -- Choose random enemy type
    e_type = 1 + flr(rnd(3))
    
    -- Pick a random direction
    local dir = rnd(1)

    -- Spawn enemy in the direction (relative to player), off-screen
    local eX,eY=plyr.x+cos(dir)*100,plyr.y+sin(dir)*100

    add(enemies, enemy_types[e_type]:new{
        x = eX,
        y = eY,
        projs = {},	-- Redeclare so all enemies have unique projectile lists
    })

	enemy_types = {wine, beer, ginger_beer}
end

function spawn_enemy()
    counters.enemy_respawn = enemy_respawn_gap

    -- Choose random enemy type
    e_type = 1 + flr(rnd(3))
    
    -- Pick a random direction
    local dir = rnd(1)

    -- Spawn enemy in the direction (relative to player), off-screen
    local eX,eY=plyr.x+cos(dir)*100,plyr.y+sin(dir)*100

    add(enemies, enemy_types[e_type]:new{
        x = eX,
        y = eY,
        projs = {},	-- Redeclare so all enemies have unique projectile lists
    })
end