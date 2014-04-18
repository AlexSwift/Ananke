function GM:CreateTeams()

	-- Don't do this if not teambased. But if it is teambased we
	-- create a few teams here as an example. If you're making a teambased
	-- gamemode you should override this function in your gamemode
	if ( !GAMEMODE.TeamBased ) then return end
	
	TEAM_BLUE = 1
	team.SetUp( TEAM_BLUE, "Blue Team", Color( 0, 0, 255 ) )
	team.SetSpawnPoint( TEAM_BLUE, "ai_hint" ) -- <-- This would be info_terrorist or some entity that is in your map
	
	TEAM_ORANGE = 2
	team.SetUp( TEAM_ORANGE, "Orange Team", Color( 255, 150, 0 ) )
	team.SetSpawnPoint( TEAM_ORANGE, "sky_camera" ) -- <-- This would be info_terrorist or some entity that is in your map
	
	TEAM_SEXY = 3
	team.SetUp( TEAM_SEXY, "Sexy Team", Color( 255, 150, 150 ) )
	team.SetSpawnPoint( TEAM_SEXY, "info_player_start" ) -- <-- This would be info_terrorist or some entity that is in your map
	
	team.SetSpawnPoint( TEAM_SPECTATOR, "worldspawn" ) 

end