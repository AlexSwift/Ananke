function GM:HUDShouldDraw( name )

	-- Allow the weapon to override this
	local ply = LocalPlayer()
	if ( IsValid( ply ) ) then
	
		local wep = ply:GetActiveWeapon()
		
		if (wep && wep:IsValid() && wep.HUDShouldDraw != nil) then
		
			return wep.HUDShouldDraw( wep, name )
			
		end
		
	end

	return true;
end