-- enemy base class object
enemy = {
    x = 64,
    y = 64,
    spd = 1, -- speed
    rad = 2, -- circle radius
    clr = 12, -- colour
    -- todo
    -- type (beer vs cocktail)

    -- constructor for enemy class
    new=function (self, tbl)
        tbl = tbl or {} -- incase the table is empty
        setmetatable(tbl, {
            __index=self
        })
        return tbl
    end,

    update=function (self)
        -- if offscreen, reset positions, else add speed
        self.x = (self.x - self.rad > 127) and 0 or (self.x + self.spd)
        self.y = (self.y - self.rad > 127) and 0 or (self.y + self.spd)
    end,

    draw= function (self)
        circfill(
            self.x,
            self.y,
            self.rad,
            self.clr
        )
    end
}

beer = enemy:new({
    x=40,
    spd = 1,
    clr = 10,
    rad = 3,
})

wine = enemy:new({
    x = 20,
    spd = 3,
    clr = 2,
})