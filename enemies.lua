function enemies_setup()
	enemies = {}

    -- enemy base class object
    enemy = class:new({
        x = -1,
        y = -1,
        spd = 20,        -- speed
        collide_r = 2,  -- circle radius
        clr = 12,       -- colour
        name = "enemy",
        projs = {},
        reward = 10,
        health = 10,

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
        update = function (_ENV)
            -- comparing enemy position to current player position
            local px = global.plyr.x
            local py = global.plyr.y

            -- find direction to player
            local d = atan2(px - x , py - y)
            
            -- move by 1 unit
            x += cos(d) * spd
            y += sin(d) * spd
            
            -- if enemy at player position, health decreases
            -- replace w goated collisions later
            if x == px or y == py then global.plyr.h -= 10 end

            -- Transform enemy coords to screen space
            -- Then div by 8 to place into one of 256 "bins" in screen_damage_matrix
            local xidx,yidx=flr((x-px+64)/8),flr((y-py+64)/8)
            -- If the enemy is on screen...
            if (1<=xidx and xidx<=16) and (1<=yidx and yidx<=16) then
                -- Decrement their health by whatever is in that bin
                health -= screen_damage_mtrx[xidx][yidx]
            end
        end,

        -- TODO: different draw for different enemies
        draw = function(_ENV)
            spr(2, x-4, y-4)
            line(x-4,y+6,x+4,y+6,8) line(x-4,y+6,x-4+health/10*8,y+6,9) -- Health bar
        end
    })

    -- enemy class entities
    -- more subclasses can be added if needed e.g. drinks, evil old men, etc
    beer = enemy:new({
        spd = 0.5,
        clr = 10,
        rad = 3,
        name = "beer"
    })

    ginger_beer = beer:new({
        clr = 4,
        name = "ginger beer"
    })

    wine = enemy:new({
        spd = 0.25,
        clr = 2,
        name = "wine"
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