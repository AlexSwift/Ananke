function GM:PlayerJoinTeam( ply, teamid )
	
	local iOldTeam = ply:Team()
	
	if ( ply:Alive() ) then
		if (iOldTeam == TEAM_SPECTATOR || iOldTeam == TEAM_UNASSIGNED) then
			ply:KillSilent()
		else
			ply:Kill()
		end
	end

	ply:SetTeam( teamid )
	ply.LastTeamSwitch = RealTime()
	
	GAMEMODE:OnPlayerChangedTeam( ply, iOldTeam, teamid )
	
end