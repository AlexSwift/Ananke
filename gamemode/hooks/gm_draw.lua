if not CLIENT then return end

hook.Add( 'HUDPaint' , 'Ananke.core.menu.draw' , function( )
	if not Ananke.core.menu.Enabled then return end
	
	local mp = { x = 0 , y = 0 }
	
	if gui.MousePos() ~= mp then
		for k,v in pairs(Anenke.core.menu.ActiveElements) do
			v:OnCursorMoved()
		end
	end

	core.menu.MousePos = mp
	mp = nil; -- __gc

	for i = 1 , #elements do
		GAMEMODE:DrawMenu( )
	end
	
	return
end)