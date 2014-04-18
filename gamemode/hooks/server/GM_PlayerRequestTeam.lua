function GM:PlayerRequestTeam( ply, teamid )
	
	-- No changing teams if not teambased!
	if ( !GAMEMODE.TeamBased ) then return end
	
	-- This team isn't joinable
	if ( !team.Joinable( teamid ) ) then 
		ply:ChatPrint( "You can't join that team" )
	return end
	
	-- This team isn't joinable
	if ( !GAMEMODE:PlayerCanJoinTeam( ply, teamid ) ) then 
		-- Messages here should be outputted by this function
	return end
	
	GAMEMODE:PlayerJoinTeam( ply, teamid )
	
end

concommand.Add( "changeteam", function( pl, cmd, args ) hook.Call( "PlayerRequestTeam", GAMEMODE, pl, tonumber(args[1]) ) end )
