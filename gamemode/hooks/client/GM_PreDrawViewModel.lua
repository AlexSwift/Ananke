function GM:PreDrawViewModel( ViewModel, Player, Weapon )
		
	if ( !IsValid( Weapon ) ) then return false end

	player_manager.RunClass( Player, "PreDrawViewModel", ViewModel, Weapon )

	if ( Weapon.PreDrawViewModel == nil ) then return false end
	return Weapon:PreDrawViewModel( ViewModel, Weapon, Player )
	
end
