
proj_parent = {
	size=4,
}

function create_proj(x, y, type)
	local proj = {}
	
	if type==0 then
		proj = {
			x=x, y=y, col_r=6,
			draw = function(self)
				circfill(self.x, self.y, self.size, 0)
			end,
			update = function(self, parent_enemy)
				dir = atan2(parent_enemy.x-self.x, parent_enemy.y-self.y)
				self.x += cos(dir)
				self.y += sin(dir)

				if (collide_2(self, parent_enemy)) del(parent_enemy.projs, self)

				
			end,
		}
	end

	return setmetatable(proj, {__index=proj_parent})
end

item_parent = {
	
	n = 60, type=0,
	cooldown = function(self)
		if global_cnt % self.n == 0 then
			local near_e = 0
			local near_d = 0
			for e in all(enemies) do
				local dist = sqrt((p.x-e.x)^2, (p.y-e.y)^2)
				if dist > near_d then
					near_e = e
				end
			end
			if near_e != 0 then
				add(near_e.projs, create_proj(p.x, p.y, self.type))
			end
		end
	end
}

function create_item(type)
	local item = {t=0}
	if (type == 0) item.n = 60

	return setmetatable(item, {__index=item_parent})
end