-- enemy base class object
enemy = class:new({
    x = -1,
    y = -1,
    spd = 1, -- speed
    rad = 2, -- circle radius
    clr = 12, -- colour
    name = "enemy",

    -- move towards player x, y 
    update=function (_ENV)
        -- comparing enemy position to current player position
        local px = global.plyr.x
        local py = global.plyr.y
        
        local dx = px - x 
        local dy = py - y 

        -- calculate eucliean distance
        local d = sqrt((dx*dx), (dy*dy))
        -- normalise distance vectors
        dx /= d
        dy /= d
        
        printh("class " ..tostr(name).. " x: "..x.. " y: "..y.." || dx: "..dx.." dy: "..dy)

        -- if offscreen, reset positions, else add speed
        x += dx * spd
        y += dy * spd
        
        if x == px or y == py then global.plyr.h -= 10 end

        if x > 127 or x < 0 then
            x = global.maxD + flr(rnd(128))
        end
        if y > 127 or y < 0 then
            y = global.maxD + flr(rnd(128))
        end
    end,

    draw= function (_ENV)
        circfill(
            x,
            y,
            rad,
            clr
        )
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

gingerBeer = beer:new({
    clr = 4,
    name = "ginger beer"
})

wine = enemy:new({
    spd = 0.25,
    clr = 2,
    name = "wine"
})