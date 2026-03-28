-- allows global variables to be updated whilst class instances do stuff 
global = _ENV

-- basic class template, initiate any class by calling class:new()
class = setmetatable({
    -- constructor changes environment to the class itself, so self. isnt needed anymore within class functions :)
    new=function (_ENV, tbl)
        tbl = tbl or {} -- incase the table is empty
        setmetatable(tbl, {
            __index=_ENV
        })
        return tbl
    end,
}, {__index=_ENV})