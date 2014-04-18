function GM:PlayerSilentDeath( Victim )

	Victim.NextSpawnTime = CurTime() + 2
	Victim.DeathTime = CurTime()

end