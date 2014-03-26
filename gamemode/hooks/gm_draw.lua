if not CLIENT then return end

hook.Add( 'HUDPaint' , 'Ananke.core.menu.draw' , function( )
	if not Ananke.core.Menu:IsEnabled() then return end
	
	local mp = { x = 0 , y = 0 }
	
	if gui.MousePos() ~= mp then
		for k,v in pairs(Ananke.core.menu:GetActiveMenus()) do
			v:OnCursorMoved()
		end
	end

	Ananke.core.Menu.MousePos = mp
	mp = nil; -- __gc

	for i = 1 , #elements do
		GAMEMODE:DrawMenu( )
	end
	
	return
end)