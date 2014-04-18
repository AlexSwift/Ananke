function GM:AdjustMouseSensitivity( fDefault )

	local ply = LocalPlayer()
	if (!ply || !ply:IsValid()) then return -1 end

	local wep = ply:GetActiveWeapon()
	if ( wep && wep.AdjustMouseSensitivity ) then
		return wep:AdjustMouseSensitivity()
	end

	return -1
	
end