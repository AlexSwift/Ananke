extentions = {}

function extentions.Initialise()

	f,d = file.Find( GM.Name .. "/gamemode/extentions/*.lua", "LUA" )

	print('Loading Extentions :')
	for k,v in pairs(f) do
		if v == 'extentions.lua' then continue end
		if file.Size( GM.Name .. '/gamemode/extentions/'..v ,"LUA") == 0 then continue end
		print('\tLoading ' .. v)
		do
			include( GM.Name .."/gamemode/extenstions/" .. v)
		end
	end


end

extentions.Initialise()

