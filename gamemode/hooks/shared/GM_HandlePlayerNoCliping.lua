function GM:HandlePlayerNoClipping( ply, velocity )

	if ( ply:GetMoveType() != MOVETYPE_NOCLIP || ply:InVehicle() ) then 

		if ( ply.m_bWasNoclipping ) then

			ply.m_bWasNoclipping = nil
			ply:AnimResetGestureSlot( GESTURE_SLOT_CUSTOM )
			if ( CLIENT ) then ply:SetIK( true ); end

		end

		return

	end

	if ( !ply.m_bWasNoclipping ) then

		ply:AnimRestartGesture( GESTURE_SLOT_CUSTOM, ACT_GMOD_NOCLIP_LAYER, false )
		if ( CLIENT ) then ply:SetIK( false ); end

	end

	return true

end