function GM:PlayerShouldTaunt( ply, actid )
	
	-- The default behaviour is to always let them act
	-- Some gamemodes will obviously want to stop this for certain players by returning false
	return true
		
end