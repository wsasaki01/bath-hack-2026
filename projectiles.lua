-- Parent class
proj_parent = {
	size=4,
}

function create_proj(x, y, type)
	local proj = {}
	
	if type==0 then
		proj = {
			x=x, y=y,
			draw = function(self)
				circfill(self.x, self.y, self.size, 0)
			end,
			update = function(self, tx, ty)
				dir = atan2(tx-self.x, ty-self.y)
				self.x += cos(dir)
				self.y += sin(dir)

				-- TODO: Cause damage on collision
			end,
		}
	end

	return setmetatable(proj, {__index=proj_parent})
end

item_parent = {
	-- Spawn this item every N frames
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
			add(near_e.projs, create_proj(p.x, p.y, self.type))
		end
	end
}

function create_item(type)
	local item = {t=0}
	if (type == 0) item.n = 60

	return setmetatable(item, {__index=item_parent})
end