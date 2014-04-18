local sv_alltalk = GetConVar( "sv_alltalk" )

--[[---------------------------------------------------------
   Name: gamemode:PlayerCanHearPlayersVoice()
		Can this player see the other player's voice?
		Returns 2 bools. 
		1. Can the player hear the other player
		2. Can they hear them spacially
-----------------------------------------------------------]]
function GM:PlayerCanHearPlayersVoice( pListener, pTalker )
	
	local alltalk = sv_alltalk:GetInt()
	if ( alltalk >= 1 ) then return true, alltalk == 2 end

	return pListener:Team() == pTalker:Team(), false
	
end