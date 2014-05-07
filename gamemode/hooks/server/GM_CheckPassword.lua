function GM:CheckPassword( steamid, networkid, server_password, password, name )

	-- We could check for banned users here and kick them using a new message upon join.

	-- The server has sv_password set
	if ( server_password != "" ) then

		-- The joining clients password doesn't match sv_password
		if ( server_password != password ) then
			return false, "#GameUI_ServerRejectBadPassword"
		end

	end
	
	--
	-- Returning true means they're allowed to join the server
	--
	return true

end