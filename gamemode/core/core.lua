core = {}

function core.Initialise()

	core.Loaded = {}

	local f,d = file.Find( "gamemodes/wp_base/gamemode/core/shared/*.lua", "GAME" )

	core.Loaded['shared'] = {f,d}
	print('Loading Shared :')

	for k,v in pairs(f) do
		if SERVER then
			print('\tLoading ' .. v)
			AddCSLuaFile(v)
			include(v)
		else
			print('\tLoading ' .. v)
			include(v)
		end
	end

	if SERVER then

		f,d = file.Find( "gamemodes/wp_base/gamemode/core/server/*.lua", "GAME" )

		core.Loaded['shared'] = {f,d}
		print('Loading Server :')
		for k,v in pairs(f) do
			print('\tLoading ' .. v)
			include(v)
		end

	else

		f,d = file.Find( "gamemodes/wp_base/gamemode/core/client/*.lua", "GAME" )

		core.Loaded['shared'] = {f,d}
		print('Loading Server :')
		for k,v in pairs(f) do
			print('\tLoading ' .. v)
			include(v)
		end

	end

end

core.Initialise()


-- Will have to rewrite for use on dedicated servers, and Client file system uses Lua_temp for file structure.
