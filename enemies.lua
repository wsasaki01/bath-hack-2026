-- enemy base class object
enemy = {
    x = 64,
    y = 64,
    spd = 1, -- speed
    rad = 2, -- circle radius
    clr = 4, -- colour
    -- todo
    -- type (beer vs cocktail)

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

enemy2 = {
    x=32,
    clr = 10, -- colour
}
setmetatable(enemy2, {__index=enemy})