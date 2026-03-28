function create_player()
	return {
		x=0,y=0,
		move = function(self)
			if btn(0) then
				self.x -= 1
			end
			if btn(1) then
				self.x += 1
			end
			if btn(2) then
				self.y -= 1
			end
			if btn(3) then
				self.y += 1
			end
		end,
		draw = function(self)
			spr(1, self.x, self.y)
		end
	}
end