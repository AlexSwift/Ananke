function GM:PlayerInitialSpawn( pl )

	pl:SetTeam( TEAM_UNASSIGNED )
	
	if ( GAMEMODE.TeamBased ) then
		pl:ConCommand( "gm_showteam" )
	end

end