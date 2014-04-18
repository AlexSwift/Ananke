function GM:PlayerSelectSpawn( pl )

	if ( GAMEMODE.TeamBased ) then
	
		local ent = GAMEMODE:PlayerSelectTeamSpawn( pl:Team(), pl )
		if ( IsValid(ent) ) then return ent end
	
	end

	-- Save information about all of the spawn points
	-- in a team based game you'd split up the spawns
	if ( !IsTableOfEntitiesValid( self.SpawnPoints ) ) then
	
		self.LastSpawnPoint = 0
		self.SpawnPoints = ents.FindByClass( "info_player_start" )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_deathmatch" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_combine" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_rebel" ) )
		
		-- CS Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_counterterrorist" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_terrorist" ) )
		
		-- DOD Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_axis" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_allies" ) )

		-- (Old) GMod Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "gmod_player_start" ) )
		
		-- TF Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_teamspawn" ) )
		
		-- INS Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "ins_spawnpoint" ) )  

		-- AOC Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "aoc_spawnpoint" ) )

		-- Dystopia Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "dys_spawn_point" ) )

		-- PVKII Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_pirate" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_viking" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_knight" ) )

		-- DIPRIP Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "diprip_start_team_blue" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "diprip_start_team_red" ) )
 
		-- OB Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_red" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_blue" ) )        
 
		-- SYN Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_coop" ) )
 
		-- ZPS Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_human" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_zombie" ) )      
 
		-- ZM Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_deathmatch" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_zombiemaster" ) )  		

	end
	
	local Count = table.Count( self.SpawnPoints )
	
	if ( Count == 0 ) then
		Msg("[PlayerSelectSpawn] Error! No spawn points!\n")
		return nil
	end
	
	-- If any of the spawnpoints have a MASTER flag then only use that one.
	-- This is needed for single player maps.
	for k, v in pairs( self.SpawnPoints ) do
		
		if ( v:HasSpawnFlags( 1 ) ) then
			return v
		end
		
	end
	
	local ChosenSpawnPoint = nil
	
	-- Try to work out the best, random spawnpoint
	for i=0, Count do
	
		ChosenSpawnPoint = table.Random( self.SpawnPoints )

		if ( ChosenSpawnPoint &&
			ChosenSpawnPoint:IsValid() &&
			ChosenSpawnPoint:IsInWorld() &&
			ChosenSpawnPoint != pl:GetVar( "LastSpawnpoint" ) &&
			ChosenSpawnPoint != self.LastSpawnPoint ) then
			
			if ( hook.Call( "IsSpawnpointSuitable", GAMEMODE, pl, ChosenSpawnPoint, i == Count ) ) then
			
				self.LastSpawnPoint = ChosenSpawnPoint
				pl:SetVar( "LastSpawnpoint", ChosenSpawnPoint )
				return ChosenSpawnPoint
			
			end
			
		end
			
	end
	
	return ChosenSpawnPoint
	
end