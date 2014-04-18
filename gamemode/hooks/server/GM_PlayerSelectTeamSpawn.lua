function GM:PlayerSelectTeamSpawn( TeamID, pl )

	local SpawnPoints = team.GetSpawnPoints( TeamID )
	if ( !SpawnPoints || table.Count( SpawnPoints ) == 0 ) then return end
	
	local ChosenSpawnPoint = nil
	
	for i=0, 6 do
	
		local ChosenSpawnPoint = table.Random( SpawnPoints )
		if ( hook.Call( "IsSpawnpointSuitable", GAMEMODE, pl, ChosenSpawnPoint, i == 6 ) ) then
			return ChosenSpawnPoint
		end
	
	end
	
	return ChosenSpawnPoint

end