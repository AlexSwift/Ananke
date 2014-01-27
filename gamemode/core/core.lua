core = {}

function core.Initialise()

	core.Loaded = {}

	local f,d = file.Find( GM.Name .. "/gamemode/core/shared/*.lua", "LUA" )

	core.Loaded['shared'] = {f,d}
	print('Loading Shared :')

	for k,v in pairs(f) do
		if SERVER then
			print('\tLoading ' .. v)
			do
				AddCSLuaFile( GM.Name .. "/gamemode/core/shared/" .. v)
				AddCSLuaFile( GM.Name .. "/gamemode/core/shared/" .. v )
				include( GM.Name .. "/gamemode/core/shared/" .. v)
			end
		else
			print('\tLoading ' .. v)
			do
				include( GM.Name .. "/gamemode/core/shared/" .. v)
			end
		end
	end


	f,d = file.Find( GM.Name .. "/gamemode/core/client/*.lua", "LUA" )
	
	core.Loaded['client'] = {f,d}
	print('Loading client :') 
	for k,v in pairs(f) do
		do
			if SERVER then
				AddCSLuaFile( GM.Name .. "/gamemode/core/client/" .. v)
			else
				include( GM.Name .. "/gamemode/core/client/" .. v)
			end
		end
	end
		
	if SERVER then

		f,d = file.Find( GM.Name .. "/gamemode/core/server/*.lua", "LUA" )

		core.Loaded['server'] = {f,d}
		print('Loading Server :')
		for k,v in pairs(f) do
			if file.Size( GM.Name .. '/gamemode/core/server/'..v , "LUA") == 0 then continue end
			print('\tLoading ' .. v)
			do
				include( GM.Name .. "/gamemode/core/server/" ..v)
			end
		end

	end

end


-- Will have to rewrite for use on dedicated servers, and Client file system uses Lua_temp for file structure.
