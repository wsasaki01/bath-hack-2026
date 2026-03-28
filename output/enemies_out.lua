
enemy = {
    x = 64,
    y = 64,
    spd = 1, 
    rad = 2, 
    clr = 12, 
    
    

    
    new=function (self, tbl)
        tbl = tbl or {} 
        setmetatable(tbl, {
            __index=self
        })
        return tbl
    end,

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