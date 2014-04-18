function GM:PostDrawViewModel( ViewModel, Player, Weapon )

	if ( !IsValid( Weapon ) ) then return false end
	
	if ( Weapon.UseHands || !Weapon:IsScripted() ) then

		local hands = Player:GetHands()
		if ( IsValid( hands ) ) then
			hands:DrawModel()
		end

	end

	player_manager.RunClass( Player, "PostDrawViewModel", ViewModel, Weapon )

	if ( Weapon.PostDrawViewModel == nil ) then return false end		
	return Weapon:PostDrawViewModel( ViewModel, Weapon, Player )
	
end