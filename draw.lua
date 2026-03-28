function _draw()
	-- Draw background
	cls()

	-- testing enemy colour
	for enemy in all(enemies) do 
		enemy:draw()
	end
	
end