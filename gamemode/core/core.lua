core = {}

function core.Initialise()

	core.Loaded = {}

	local f,d = file.Find( "gamemodes/wp_base/gamemode/core/shared/*.lua", "GAME" )

	core.Loaded['shared'] = {f,d}
	print('Loading Shared :')

	for k,v in pairs(f) do
		if file.Size('gamemodes/wp_base/gamemode/core/shared/'..v ,"GAME") == 0 then continue end
		if SERVER then
			print('\tLoading ' .. v)
			AddCSLuaFile("shared/" .. v)
			include("shared/" .. v)
		else
			print('\tLoading ' .. v)
			include( "shared/" .. v)
		end
	end

	if SERVER then

		f,d = file.Find( "gamemodes/wp_base/gamemode/core/server/*.lua", "GAME" )

		core.Loaded['server'] = {f,d}
		print('Loading Server :')
		for k,v in pairs(f) do
			if file.Size('gamemodes/wp_base/gamemode/core/server/'..v ,"GAME") == 0 then continue end
			print('\tLoading ' .. v)
			include("server/" ..v)
		end

	else

		f,d = file.Find( "gamemodes/wp_base/gamemode/core/client/*.lua", "GAME" )

		core.Loaded['client'] = {f,d}
		print('Loading client :')
		for k,v in pairs(f) do
			if file.Size('gamemodes/wp_base/gamemode/core/client/'..v ,"GAME") == 0 then continue end
			print('\tLoading ' .. v)
			include("client/" .. v)
		end

	end

end

core.Initialise()


-- Will have to rewrite for use on dedicated servers, and Client file system uses Lua_temp for file structure.
