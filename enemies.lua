function enemies_setup()
	enemies = {}

    -- enemy base class object
    enemy = class:new({
        name = "enemy",
        clr = 12,   -- colour
        sprt = 10,  -- sprite index

        x = -1,
        y = -1,
        collide_r = 2,  -- circle radius for projectiles

        dmg = 1,   -- strength of attack
        spd = 20,    -- speed

        projs = {}, -- projectiles currently moving towards enemy

        update_projs = function(self)
            for p in all(self.projs) do
                p:update(self)
            end
        end,

        draw_projs = function(_ENV)
            for p in all(projs) do
                p:draw()
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
            
            -- check for player collision
            if global.collide_3(x, y, collide_r, px, py, collide_r) then
                return dmg
            end
            return 0
        end,

        draw = function(_ENV)
            spr(sprt, x-4, y-4)
            circ(x, y, collide_r, 14)
        end
    })

    -- enemy class entities
    -- more subclasses can be added if needed e.g. drinks, evil old men, etc
    beer = enemy:new({
        spd = 0.5,
        clr = 10,
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
end