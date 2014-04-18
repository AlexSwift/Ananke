function GM:HandlePlayerLanding( ply, velocity, WasOnGround ) 

	if ( ply:GetMoveType() == MOVETYPE_NOCLIP ) then return end

	if ( ply:IsOnGround() && !WasOnGround ) then
		ply:AnimRestartGesture( GESTURE_SLOT_JUMP, ACT_LAND, true );
	end

end