
enemy = {
    x = 64,
    y = 64,
    spd = 1, 
    rad = 2, 
    clr = 4, 
    
    

    update=function (self)
        
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
    clr = 10, 
}
setmetatable(enemy2, {__index=enemy})