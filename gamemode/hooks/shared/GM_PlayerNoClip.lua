function GM:PlayerNoClip( pl, on )
	
	-- Allow noclip if we're in single player
	if ( game.SinglePlayer() ) then return true end
	
	-- Don't if it's not.
	return false
	
end