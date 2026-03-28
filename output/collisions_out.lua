function collide_2(a, b)
    
    return ((a.x - b.x)^2 + (a.y - b.y)^2) <= a.r^2
end

a = {x=0, y=0, r=5}
b = {x=5, y=0, r=5}

printh(collide_2(a, b))