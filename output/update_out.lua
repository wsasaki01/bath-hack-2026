function _update()
	
	if menu==1 then
		if btnp(2) and menu_idx != 1 then
			menu_idx -= 1
		elseif btnp(3) and menu_idx != 2 then
			menu_idx += 1
		end
	end
end