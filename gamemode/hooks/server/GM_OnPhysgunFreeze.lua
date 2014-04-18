function GM:OnPhysgunFreeze( weapon, phys, ent, ply )
	
	-- Object is already frozen (!?)
	if ( !phys:IsMoveable() ) then return false end
	if ( ent:GetUnFreezable() ) then return false end
	
	phys:EnableMotion( false )
	
	-- With the jeep we need to pause all of its physics objects
	-- to stop it spazzing out and killing the server.
	if (ent:GetClass() == "prop_vehicle_jeep") then
	
		local objects = ent:GetPhysicsObjectCount()
		
		for i=0, objects-1 do
		
			local physobject = ent:GetPhysicsObjectNum( i )
			physobject:EnableMotion( false )
			
		end
	
	end
	
	-- Add it to the player's frozen props
	ply:AddFrozenPhysicsObject( ent, phys )
	
	return true
	
end