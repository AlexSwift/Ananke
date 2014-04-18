function GM:VehicleMove( ply, vehicle, mv )

	--
	-- On duck toggle third person view
	--
	if ( mv:KeyPressed( IN_DUCK ) ) then
		vehicle:SetThirdPersonMode( !vehicle:GetThirdPersonMode() );
	end

	--
	-- Adjust the camera distance with the mouse wheel
	--
	local iWheel = ply:GetCurrentCommand():GetMouseWheel()
	if ( iWheel != 0 ) then
		-- The distance is a multiplier
		-- Actual camera distance = ( renderradius + renderradius * dist )
		-- so -1 will be zero.. clamp it there.
		local newdist = math.Clamp( vehicle:GetCameraDistance() - iWheel * 0.03 * (1.1 + vehicle:GetCameraDistance()), -1, 10 )
		vehicle:SetCameraDistance( newdist );
	end

end