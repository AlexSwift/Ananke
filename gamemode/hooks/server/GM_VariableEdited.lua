function GM:VariableEdited( ent, ply, key, val, editor )

	if ( !IsValid( ent ) ) then return end
	if ( !IsValid( ply ) ) then return end

	--
	-- Check with the gamemode that we can edit the entity
	--
	local CanEdit = hook.Run( "CanEditVariable", ent, ply, key, val, editor )
	if ( !CanEdit ) then return end


	--
	-- Actually apply the edited value
	--
	ent:EditValue( key, val )

end