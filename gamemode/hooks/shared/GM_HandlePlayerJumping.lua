function GM:HandlePlayerJumping( ply, velocity )
	
	if ( ply:GetMoveType() == MOVETYPE_NOCLIP ) then
		ply.m_bJumping = false;
		return
	end

	-- airwalk more like hl2mp, we airwalk until we have 0 velocity, then it's the jump animation
	-- underwater we're alright we airwalking
	if ( !ply.m_bJumping && !ply:OnGround() && ply:WaterLevel() <= 0 ) then
	
		if ( !ply.m_fGroundTime ) then

			ply.m_fGroundTime = CurTime()
			
		elseif (CurTime() - ply.m_fGroundTime) > 0 && velocity:Length2D() < 0.5 then

			ply.m_bJumping = true
			ply.m_bFirstJumpFrame = false
			ply.m_flJumpStartTime = 0

		end
	end
	
	if ply.m_bJumping then
	
		if ply.m_bFirstJumpFrame then

			ply.m_bFirstJumpFrame = false
			ply:AnimRestartMainSequence()

		end
		
		if ( ply:WaterLevel() >= 2 ) ||	( (CurTime() - ply.m_flJumpStartTime) > 0.2 && ply:OnGround() ) then

			ply.m_bJumping = false
			ply.m_fGroundTime = nil
			ply:AnimRestartMainSequence()

		end
		
		if ply.m_bJumping then
			ply.CalcIdeal = ACT_MP_JUMP
			return true
		end
	end
	
	return false
end
