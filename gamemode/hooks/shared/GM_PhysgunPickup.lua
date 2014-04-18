function GM:PhysgunPickup( ply, ent )

	-- Don't pick up players
	if ( ent:GetClass() == "player" ) then return false end

	return true
end
