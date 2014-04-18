function GM:UpdateAnimation( ply, velocity, maxseqgroundspeed )	

	local len = velocity:Length()
	local movement = 1.0
	
	if ( len > 0.2 ) then
			movement =  ( len / maxseqgroundspeed )
	end
	
	rate = math.min( movement, 2 )

	-- if we're under water we want to constantly be swimming..
	if ( ply:WaterLevel() >= 2 ) then
		rate = math.max( rate, 0.5 )
	elseif ( !ply:IsOnGround() && len >= 1000 ) then 
		rate = 0.1;
	end
	
	ply:SetPlaybackRate( rate )
	
	if ( ply:InVehicle() ) then

		local Vehicle =  ply:GetVehicle()
		
		-- We only need to do this clientside..
		if ( CLIENT ) then
			--
			-- This is used for the 'rollercoaster' arms
			--
			local Velocity = Vehicle:GetVelocity()
			local fwd = Vehicle:GetUp()                       
			local dp = fwd:Dot( Vector(0,0,1) )
			local dp2 = fwd:Dot( Velocity )

			ply:SetPoseParameter( "vertical_velocity", (dp<0 and dp or 0)+dp2*0.005 ) 

			-- Pass the vehicles steer param down to the player
			local steer = Vehicle:GetPoseParameter( "vehicle_steer" )
			steer = steer * 2 - 1 -- convert from 0..1 to -1..1
			ply:SetPoseParameter( "vehicle_steer", steer  ) 
		end
		
	end
	
	if ( CLIENT ) then
		GAMEMODE:GrabEarAnimation( ply )
		GAMEMODE:MouthMoveAnimation( ply )
	end
	
end

function GM:GrabEarAnimation( ply )	

	ply.ChatGestureWeight = ply.ChatGestureWeight or 0

	-- Don't show this when we're playing a taunt!
	if ( ply:IsPlayingTaunt() ) then return end

	if ( ply:IsTyping() ) then
		ply.ChatGestureWeight = math.Approach( ply.ChatGestureWeight, 1, FrameTime() * 5.0 );
	else
		ply.ChatGestureWeight = math.Approach( ply.ChatGestureWeight, 0, FrameTime()  * 5.0 );
	end
	
	if ( ply.ChatGestureWeight > 0 ) then
	
		ply:AnimRestartGesture( GESTURE_SLOT_VCD, ACT_GMOD_IN_CHAT, true )
		ply:AnimSetGestureWeight( GESTURE_SLOT_VCD, ply.ChatGestureWeight )
		
	end

end

function GM:MouthMoveAnimation( ply )

	local FlexNum = ply:GetFlexNum() - 1
	if ( FlexNum <= 0 ) then return end
	
	for i=0, FlexNum-1 do
	
		local Name = ply:GetFlexName( i )

		if ( Name == "jaw_drop" || Name == "right_part" || Name == "left_part" || Name == "right_mouth_drop" || Name == "left_mouth_drop"  ) then

			if ( ply:IsSpeaking() ) then
				ply:SetFlexWeight( i, math.Clamp( ply:VoiceVolume() * 2, 0, 2 ) )
			else
				ply:SetFlexWeight( i, 0 )
			end
		end
		
	end
	
end