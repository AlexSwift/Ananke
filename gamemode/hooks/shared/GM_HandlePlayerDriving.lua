function GM:HandlePlayerDriving( ply )

	if ply:InVehicle() then
		local pVehicle = ply:GetVehicle()
		
		if ( pVehicle.HandleAnimation != nil ) then
		
			local seq = pVehicle:HandleAnimation( ply )
			if ( seq != nil ) then
				ply.CalcSeqOverride = seq
				return true
			end
			
		else
		
			local class = pVehicle:GetClass()
			
			if ( class == "prop_vehicle_jeep" ) then
				ply.CalcSeqOverride = ply:LookupSequence( "drive_jeep" )
			elseif ( class == "prop_vehicle_airboat" ) then
				ply.CalcSeqOverride = ply:LookupSequence( "drive_airboat" )
			elseif ( class == "prop_vehicle_prisoner_pod" && pVehicle:GetModel() == "models/vehicles/prisoner_pod_inner.mdl" ) then
				-- HACK!!
				ply.CalcSeqOverride = ply:LookupSequence( "drive_pd" )
			else
				ply.CalcSeqOverride = ply:LookupSequence( "sit_rollercoaster" )
			end
			
			return true
		end
	end
	
	return false
end