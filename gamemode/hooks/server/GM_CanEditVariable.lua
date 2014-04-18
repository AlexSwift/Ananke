function GM:CanEditVariable( ent, ply, key, val, editor )

	return ply:IsAdmin()

end