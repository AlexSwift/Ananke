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
			do
				AddCSLuaFile("wp_base/gamemode/core/shared/" .. v)
				include("wp_base/gamemode/core/shared/" .. v)
			end
		else
			print('\tLoading ' .. v)
			do
				include( "wp_base/gamemode/core/shared/" .. v)
			end
		end
	end


	f,d = file.Find( "gamemodes/wp_base/gamemode/core/client/*.lua", "GAME" )
	
	core.Loaded['client'] = {f,d}
	if CLIENT then print('Loading client :') end
	for k,v in pairs(f) do
		if file.Size('gamemodes/wp_base/gamemode/core/client/'..v ,"GAME") == 0 then continue end
		if CLIENT then print('\tLoading ' .. v) end
		do
			if SERVER then
				AddCSLuaFile("wp_base/gamemode/core/client/" .. v)
			else
				include("wp_base/gamemode/core/client/" .. v)
			end
		end
	end

	if SERVER then

		f,d = file.Find( "gamemodes/wp_base/gamemode/core/server/*.lua", "GAME" )

		core.Loaded['server'] = {f,d}
		print('Loading Server :')
		for k,v in pairs(f) do
			if file.Size('gamemodes/wp_base/gamemode/core/server/'..v ,"GAME") == 0 then continue end
			print('\tLoading ' .. v)
			do
				include("wp_base/gamemode/core/server/" ..v)
			end
		end

	end

end

core.Initialise()


-- Will have to rewrite for use on dedicated servers, and Client file system uses Lua_temp for file structure.
