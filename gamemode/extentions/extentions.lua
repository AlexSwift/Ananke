extentions = {}

function extentions.Initialise()

	f,d = file.Find( "wp_base/gamemode/extentions/*.lua", "LUA" )

	print('Loading Extentions :')
	for k,v in pairs(f) do
		if v == 'extentions.lua' then continue end
		if file.Size('wp_base/gamemode/extentions/'..v ,"LUA") == 0 then continue end
		print('\tLoading ' .. v)
		do
			include("wp_base/gamemode/extenstions/" .. v)
		end
	end


end

extentions.Initialise()

