-- enemy base class object
enemy = class:new({
    x = 64,
    y = 64,
    spd = 1, -- speed
    rad = 2, -- circle radius
    clr = 12, -- colour
    -- todo
    -- type (beer vs cocktail)

    
    update=function (_ENV)
        -- if offscreen, reset positions, else add speed
        x = (x - rad > 127) and 0 or (x + spd)
        y = (y - rad > 127) and 0 or (y + spd)
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
    x=40,
    spd = 1,
    clr = 10,
    rad = 3,
})

gingerBeer = beer:new({
    x = 70,
    clr = 4
})

wine = enemy:new({
    x = 20,
    spd = 3,
    clr = 2,
})