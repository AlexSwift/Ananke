function GM:PreventScreenClicks( cmd )

	--
	-- Returning true in this hook will prevent screen clicking sending IN_ATTACK
	-- commands to the weapons. We want to do this in the properties system, so 
	-- that you don't fire guns when opening the properties menu. Holla!
	--

	return false

end