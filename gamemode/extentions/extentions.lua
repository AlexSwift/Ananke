extentions = {}

function extentions.Initialise()

	f,d = file.Find( "gamemodes/wp_base/gamemode/extentions/*.lua", "GAME" )

	print('Loading Extentions :')
	for k,v in pairs(f) do
		if v == 'extentions.lua' then continue end
		if file.Size('gamemodes/wp_base/gamemode/extentions/'..v ,"GAME") == 0 then continue end
		print('\tLoading ' .. v)
		do
			include("wp_base/gamemode/extenstions/" .. v)
		end
	end


end

extentions.Initialise()

