function GM:PlayerSetHandsModel( pl, ent )

	local info = player_manager.RunClass( pl, "GetHandsModel" )
	if ( info ) then
		ent:SetModel( info.model )
		ent:SetSkin( info.skin )
		ent:SetBodyGroups( info.body )
	end

end