function GM:OnViewModelChanged( vm, old, new ) 

	local ply = vm:GetOwner()
	if ( IsValid( ply ) ) then
		player_manager.RunClass( ply, "ViewModelChanged", vm, old, new );
	end

end