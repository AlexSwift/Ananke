function GM:CalcMainActivity( ply, velocity )	

	ply.CalcIdeal = ACT_MP_STAND_IDLE
	ply.CalcSeqOverride = -1

	self:HandlePlayerLanding( ply, velocity, ply.m_bWasOnGround );

	if ( self:HandlePlayerNoClipping( ply, velocity ) ||
		self:HandlePlayerDriving( ply ) ||
		self:HandlePlayerVaulting( ply, velocity ) ||
		self:HandlePlayerJumping( ply, velocity ) ||
		self:HandlePlayerDucking( ply, velocity ) ||
		self:HandlePlayerSwimming( ply, velocity ) ) then

	else

		local len2d = velocity:Length2D()
		if ( len2d > 150 ) then ply.CalcIdeal = ACT_MP_RUN elseif ( len2d > 0.5 ) then ply.CalcIdeal = ACT_MP_WALK end

	end

	ply.m_bWasOnGround = ply:IsOnGround()
	ply.m_bWasNoclipping = ( ply:GetMoveType() == MOVETYPE_NOCLIP && !ply:InVehicle() )

	return ply.CalcIdeal, ply.CalcSeqOverride

end