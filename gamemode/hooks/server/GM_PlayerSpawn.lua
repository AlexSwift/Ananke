function GM:PlayerSpawn( pl )

	--
	-- If the player doesn't have a team in a TeamBased game
	-- then spawn him as a spectator
	--
	if ( GAMEMODE.TeamBased && ( pl:Team() == TEAM_SPECTATOR || pl:Team() == TEAM_UNASSIGNED ) ) then

			pl:StripWeapons();
			
			if ( pl:Team() == TEAM_UNASSIGNED ) then
			
				pl:Spectate( OBS_MODE_FIXED )
				return
				
			end

			pl:SetTeam( TEAM_SPECTATOR )
			pl:Spectate( OBS_MODE_ROAMING )
		return
	
	end

	-- Stop observer mode
	pl:UnSpectate()

	pl:SetupHands()

	player_manager.OnPlayerSpawn( pl )
	player_manager.RunClass( pl, "Spawn" )

	-- Call item loadout function
	hook.Call( "PlayerLoadout", GAMEMODE, pl )
	
	-- Set player model
	hook.Call( "PlayerSetModel", GAMEMODE, pl )
	
end