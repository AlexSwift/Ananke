function GM:OnPlayerChangedTeam( ply, oldteam, newteam )

	-- Here's an immediate respawn thing by default. If you want to 
	-- re-create something more like CS or some shit you could probably
	-- change to a spectator or something while dead.
	if ( newteam == TEAM_SPECTATOR ) then
	
		-- If we changed to spectator mode, respawn where we are
		local Pos = ply:EyePos()
		ply:Spawn()
		ply:SetPos( Pos )
		
	elseif ( oldteam == TEAM_SPECTATOR ) then
	
		-- If we're changing from spectator, join the game
		ply:Spawn()
	
	else
	
		-- If we're straight up changing teams just hang
		--  around until we're ready to respawn onto the 
		--  team that we chose
		
	end
	
	PrintMessage( HUD_PRINTTALK, Format( "%s joined '%s'", ply:Nick(), team.GetName( newteam ) ) )
	
end
