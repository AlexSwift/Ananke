function GM:CalcViewModelView( Weapon, ViewModel, OldEyePos, OldEyeAng, EyePos, EyeAng )
		
	if ( !IsValid( Weapon ) ) then return end
	
	local vm_origin, vm_angles = EyePos, EyeAng
	
	-- Controls the position of all viewmodels
	local func = Weapon.GetViewModelPosition
	if ( func ) then
		local pos, ang = func( Weapon, EyePos*1, EyeAng*1 )
		vm_origin = pos or vm_origin
		vm_angles = ang or vm_angles
	end
	
	-- Controls the position of individual viewmodels
	func = Weapon.CalcViewModelView
	if ( func ) then
		local pos, ang = func( Weapon, ViewModel, OldEyePos*1, OldEyeAng*1, EyePos*1, EyeAng*1 )
		vm_origin = pos or vm_origin
		vm_angles = ang or vm_angles
	end
	
	return vm_origin, vm_angles
	
end