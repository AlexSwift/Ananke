-- Pool network strings used for PlayerDeaths.
util.AddNetworkString("PlayerKilledSelf")
util.AddNetworkString("PlayerKilledByPlayer")
util.AddNetworkString("PlayerKilled")

function GM:PlayerDeath( ply, inflictor, attacker )

	-- Don't spawn for at least 2 seconds
	ply.NextSpawnTime = CurTime() + 2
	ply.DeathTime = CurTime()
	
	if ( IsValid( attacker ) && attacker:GetClass() == "trigger_hurt" ) then attacker = ply end
	
	if ( IsValid( attacker ) && attacker:IsVehicle() && IsValid( attacker:GetDriver() ) ) then
		attacker = attacker:GetDriver()
	end

	if ( !IsValid( inflictor ) && IsValid( attacker ) ) then
		inflictor = attacker
	end

	-- Convert the inflictor to the weapon that they're holding if we can.
	-- This can be right or wrong with NPCs since combine can be holding a 
	-- pistol but kill you by hitting you with their arm.
	if ( IsValid( inflictor ) && inflictor == attacker && ( inflictor:IsPlayer() || inflictor:IsNPC() ) ) then
	
		inflictor = inflictor:GetActiveWeapon()
		if ( !IsValid( inflictor ) ) then inflictor = attacker end

	end

	if ( attacker == ply ) then
	
		net.Start( "PlayerKilledSelf" )
			net.WriteEntity( ply )
		net.Broadcast()
		
		MsgAll( attacker:Nick() .. " suicided!\n" )
		
	return end

	if ( attacker:IsPlayer() ) then
	
		net.Start( "PlayerKilledByPlayer" )
		
			net.WriteEntity( ply )
			net.WriteString( inflictor:GetClass() )
			net.WriteEntity( attacker )
		
		net.Broadcast()
		
		MsgAll( attacker:Nick() .. " killed " .. ply:Nick() .. " using " .. inflictor:GetClass() .. "\n" )
		
	return end
	
	net.Start( "PlayerKilled" )
	
		net.WriteEntity( ply )
		net.WriteString( inflictor:GetClass() )
		net.WriteString( attacker:GetClass() )

	net.Broadcast()
	
	MsgAll( ply:Nick() .. " was killed by " .. attacker:GetClass() .. "\n" )
	
end