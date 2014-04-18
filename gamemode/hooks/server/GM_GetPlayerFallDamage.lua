function GM:GetFallDamage( ply, flFallSpeed )

	if( GetConVarNumber( "mp_falldamage" ) > 0 ) then -- realistic fall damage is on
		return ( flFallSpeed - 526.5 ) * (100 / 396); -- the Source SDK value
	end
	
	return 10
	
end