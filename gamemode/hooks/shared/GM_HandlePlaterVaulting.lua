function GM:HandlePlayerVaulting( ply, velocity )

	if ( velocity:Length() < 1000 ) then return end
	if ( ply:IsOnGround() ) then return end

	ply.CalcIdeal = ACT_MP_SWIM	
	
	return true

end