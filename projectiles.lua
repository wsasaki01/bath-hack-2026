-- Parent class
proj_parent = {
	size=10,
}

function create_proj(x, y, type)
	local proj = {}
	if type == 0 then
		proj = {
			x=x, y=y,
			draw = function(self)
				circfill(self.x, self.y, self.size, 0)
			end,
			update = function(self)
				self.x += 1
				-- Loop around the screen
				if (self.x > 128) self.x = 0

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
		if (global_cnt % self.n == 0) add(projs, create_proj(p.x, p.y, self.type))
	end
}

function create_item(type)
	local item = {t=0}
	if (type == 0) item.n = 60

	return setmetatable(item, {__index=item_parent})
end