hook.Add( 'PlayerSpawn' , 'Ananke.PlayerHands', function( ply )

	local hands = IsValid( ply:GetHands() ) and ply:GetHands() or ents.Create( "gmod_hands" )
	
	if ( IsValid( hands ) ) then
	
		ply:SetHands( hands )
		hands:SetOwner( ply )

		local cl_playermodel = ply:GetInfo( "cl_playermodel" )
		local info = player_manager.TranslatePlayerHands( cl_playermodel )
		
		if ( info ) then
			hands:SetModel( info.model )
			hands:SetSkin( info.skin )
			hands:SetBodyGroups( info.body )
		end

		local vm = ply:GetViewModel( 0 )
		hands:AttachToViewmodel( vm )

		vm:DeleteOnRemove( hands )
		ply:DeleteOnRemove( hands )
		
		hands:Spawn()
		
 	end
end)