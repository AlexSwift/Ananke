function GM:DoAnimationEvent( ply, event, data )
	if event == PLAYERANIMEVENT_ATTACK_PRIMARY then
	
		if ply:Crouching() then
			ply:AnimRestartGesture( GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_MP_ATTACK_CROUCH_PRIMARYFIRE, true )
		else
			ply:AnimRestartGesture( GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_MP_ATTACK_STAND_PRIMARYFIRE, true )
		end
		
		return ACT_VM_PRIMARYATTACK
	
	elseif event == PLAYERANIMEVENT_ATTACK_SECONDARY then
	
		-- there is no gesture, so just fire off the VM event
		return ACT_VM_SECONDARYATTACK
		
	elseif event == PLAYERANIMEVENT_RELOAD then
	
		if ply:Crouching() then
			ply:AnimRestartGesture( GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_MP_RELOAD_CROUCH, true )
		else
			ply:AnimRestartGesture( GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_MP_RELOAD_STAND, true )
		end
		
		return ACT_INVALID
		
	elseif event == PLAYERANIMEVENT_JUMP then
	
		ply.m_bJumping = true
		ply.m_bFirstJumpFrame = true
		ply.m_flJumpStartTime = CurTime()
		
		ply:AnimRestartMainSequence()
		
		return ACT_INVALID
		
	elseif event == PLAYERANIMEVENT_CANCEL_RELOAD then
	
		ply:AnimResetGestureSlot( GESTURE_SLOT_ATTACK_AND_RELOAD )
		
		return ACT_INVALID
	end

	return nil
end
