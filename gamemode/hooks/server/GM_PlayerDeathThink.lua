function GM:PlayerDeathThink( pl )

	if (  pl.NextSpawnTime && pl.NextSpawnTime > CurTime() ) then return end

	if ( pl:KeyPressed( IN_ATTACK ) || pl:KeyPressed( IN_ATTACK2 ) || pl:KeyPressed( IN_JUMP ) ) then
	
		pl:Spawn()
		
	end
	
end