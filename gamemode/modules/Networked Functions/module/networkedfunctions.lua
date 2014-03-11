Ananke.NetworkedFunction = {}

function MODULE:Load()

	f,d = file.Find( Ananke.Name .. "/gamemode/module/MathsX/module/*.lua", "LUA" )

	print('\t\t\tLoading Networked Functions Extentions :')
	
	for k,v in pairs(f) do
		if v == 'networkedfunctions.lua' then continue end
		print('\t\t\t\tLoading ' .. v)
		include( v )
		if SERVER then 
			AddCSLuaFile( v )
		end
	end
	
end