Ananke.extentions = {}

function Ananke.extentions.Initialise()

	f,d = file.Find( GM.Name .. "/gamemode/extentions/*.lua", "LUA" )

	print('Loading Extentions :')
	
	for k,v in pairs(f) do
		if v == 'extentions.lua' then continue end
		print('\tLoading ' .. v)
		Ananke.include( v )
		if SERVER then 
			Ananke.AddCSLuaFile( v )
		end
	end


end

Ananke.extentions.Initialise()

