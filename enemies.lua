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
        
        aabb = {
            {x, y, 1},         -- top left, colour
            {x + 8, y, 1},     -- top right
            {x, y + 8, 1},     -- bottom left
            {x + 8, y + 8, 1}, -- bottom right
        },

        dmg = 10,   -- strength of attack
        spd = 1,    -- speed

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
            local dx = px - x 
            local dy = py - y 

            -- calculate eucliean distance
            local d = sqrt((dx^2), (dy^2))

            -- normalise distance vectors
            dx /= d
            dy /= d
            
            --printh("class " ..tostr(name).. " x: "..x.. " y: "..y.." || dx: "..dx.." dy: "..dy)

            -- move by 1 unit
            x += dx * spd
            y += dy * spd
            
            -- if enemy at player position, health decreases
            -- replace w goated collisions later
            if x == px or y == py then 
                global.plyr:losehp(dmg)
            end
            
            -- if offscreen, reset positions
            if x > 127 or x < 0 then
                x = global.maxD + flr(rnd(128))
            end
            if y > 127 or y < 0 then
                y = global.maxD + flr(rnd(128))
            end
        end,

        draw = function(_ENV)
            spr(sprt, x-4, y-4)

            -- drawing bounding box boundaries
            pset(x,y)
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
end