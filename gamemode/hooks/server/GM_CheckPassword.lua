function GM:CheckPassword( steamid, networkid, server_password, password, name )

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