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
        health = 20,

        update_projs = function(self)
            for p in all(self.projs) do
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
                plyr.xp += self.reward
                del(enemies, self)
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
        end,

        -- TODO: different draw for different enemies
        draw = function(_ENV)
            spr(2, x-4, y-4)
            --line(x-4,y+6,x+4,y+6,8)   -- Health bar
            --line(x-4,y+6,x-4+health/20*8,y+6,9)
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