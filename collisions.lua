function collide_2(a, b)
    -- I expect 2 object with x, y, r
    return (a.x - b.x)^2 + (a.y - b.y)^2 < r^2:
end

