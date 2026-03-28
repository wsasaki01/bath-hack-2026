-- enemy base class object
enemy = {
    x = 64,
    y = 64,
    spd = 1, -- speed
    clr = 7, -- colour
    -- todo
    -- type (beer vs cocktail)

    update=function (self)
        self.y += self.spd
    end,

    draw= function (self)
        circfill(
            self.x,
            self.y,
            2,
            self.clr
        )
    end
}

enemy2 = {
    spd = 2,
    clr = 7, -- colour
}
setmetatable(enemy, enemy2)