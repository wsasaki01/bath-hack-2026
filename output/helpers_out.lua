
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