
global = _ENV

class = setmetatable({
    
    new=function (_ENV, tbl)
        tbl = tbl or {} 
        setmetatable(tbl, {
            __index=_ENV
        })
        return tbl
    end,
}, {__index=_ENV})



enemy = class:new({
    x = 64,
    y = 64,
    spd = 1, 
    rad = 2, 
    clr = 12, 
    
    

    
    update=function (_ENV)
        
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