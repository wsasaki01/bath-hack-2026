
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
				
				if (self.x > 128) self.x = 0

				
				
			end,
		}
	end

	return setmetatable(proj, {__index=proj_parent})
end