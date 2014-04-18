function GM:GetTeamColor( ent )

	local team = TEAM_UNASSIGNED
	if (ent.Team) then team = ent:Team() end
	return GAMEMODE:GetTeamNumColor( team )

end