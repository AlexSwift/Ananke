function GM:Move( ply, mv )

	if ( drive.Move( ply, mv ) ) then return true end
	if ( player_manager.RunClass( ply, "Move", mv ) ) then return true end

end