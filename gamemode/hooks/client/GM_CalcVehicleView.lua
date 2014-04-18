function GM:CalcVehicleView( Vehicle, ply, view )

	if ( Vehicle.GetThirdPersonMode == nil ) then
		-- This hsouldn't ever happen.
		return
	end

	--
	-- If we're not in third person mode - then get outa here stalker
	--
	if ( !Vehicle:GetThirdPersonMode() ) then return view end

	-- Don't roll the camera 
	-- view.angles.roll = 0

	local mn, mx = Vehicle:GetRenderBounds()
	local radius = (mn - mx):Length()
	local radius = radius + radius * Vehicle:GetCameraDistance();

	-- Trace back from the original eye position, so we don't clip through walls/objects
	local TargetOrigin = view.origin + ( view.angles:Forward() * -radius )
	local WallOffset = 4;
		  
	local tr = util.TraceHull( {
		start	= view.origin,
		endpos	= TargetOrigin,
		filter	= function()
			return false
		end,
		mins	= Vector( -WallOffset, -WallOffset, -WallOffset ),
		maxs	= Vector( WallOffset, WallOffset, WallOffset ),
	} ) 
	
	view.origin			= tr.HitPos
	view.drawviewer		= true

	--
	-- If the trace hit something, put the camera there.
	--
	if ( tr.Hit && !tr.StartSolid) then
		view.origin = view.origin + tr.HitNormal * WallOffset
	end

	return view

end