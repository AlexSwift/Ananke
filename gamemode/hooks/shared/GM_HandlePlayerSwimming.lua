function GM:HandlePlayerSwimming( ply, velocity )

	if ( ply:WaterLevel() < 2 or ply:IsOnGround() ) then 
		ply.m_bInSwim = false
		return false 
	end
	
	ply.CalcIdeal = ACT_MP_SWIM
		
	ply.m_bInSwim = true
	return true
	
end