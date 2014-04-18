function GM:CalcView( ply, origin, angles, fov, znear, zfar )
	
	local Vehicle	= ply:GetVehicle()
	local Weapon	= ply:GetActiveWeapon()
	
	local view = {}
	view.origin 		= origin
	view.angles			= angles
	view.fov 			= fov
	view.znear			= znear
	view.zfar			= zfar
	view.drawviewer		= false

	--
	-- Let the vehicle override the view
	--
	if ( IsValid( Vehicle ) ) then return GAMEMODE:CalcVehicleView( Vehicle, ply, view ) end

	--
	-- Let drive possibly alter the view
	--
	if ( drive.CalcView( ply, view ) ) then return view end
	
	--
	-- Give the player manager a turn at altering the view
	--
	player_manager.RunClass( ply, "CalcView", view )

	-- Give the active weapon a go at changing the viewmodel position
	
	if ( IsValid( Weapon ) ) then
	
		local func = Weapon.CalcView
		if ( func ) then
			view.origin, view.angles, view.fov = func( Weapon, ply, origin*1, angles*1, fov ) -- Note: *1 to copy the object so the child function can't edit it.
		end
	
	end
	
	return view
	
end