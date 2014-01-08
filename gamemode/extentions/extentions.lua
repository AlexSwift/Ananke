extentions = {}

function extentions.Initialise()

	f,d = file.Find( "gamemodes/wp_base/gamemode/extentions/*.lua", "GAME" )

	print('Loading Extentions :')
	for k,v in pairs(f) do
		if file.Size('gamemodes/wp_base/gamemode/extentions/'..v ,"GAME") == 0 then continue end
		print('\tLoading ' .. v)
		include("extenstions/" .. v)
	end


end

extentions.Initialise()

