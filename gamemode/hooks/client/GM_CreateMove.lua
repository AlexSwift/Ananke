function GM:CreateMove( cmd )

	if ( drive.CreateMove( cmd ) ) then return true end

	if ( player_manager.RunClass( LocalPlayer(), "CreateMove", cmd ) ) then return true end

end