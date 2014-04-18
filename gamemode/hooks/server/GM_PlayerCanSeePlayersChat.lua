function GM:PlayerCanSeePlayersChat( strText, bTeamOnly, pListener, pSpeaker )
	
	if ( bTeamOnly ) then
		if ( !IsValid( pSpeaker ) || !IsValid( pListener ) ) then return false end
		if ( pListener:Team() != pSpeaker:Team() ) then return false end
	end
	
	return true
	
end
