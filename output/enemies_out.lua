
enemy = {
    x = 64,
    y = 64,
    spd = 1, 
    clr = 7,

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
    clr = 7, 
}
setmetatable(enemy, enemy2)