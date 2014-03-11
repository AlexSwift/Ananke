Ananke.MathsX = {}

function Ananke.MathsX.Initialise()

	f,d = file.Find( Ananke.Name .. "/gamemode/module/MathsX/module/*.lua", "LUA" )

	print('\t\t\tLoading MathsX Extentions :')
	
	for k,v in pairs(f) do
		if v == 'mathsx.lua' then continue end
		print('\t\t\t\tLoading ' .. v)
		include( v )
		if SERVER then 
			AddCSLuaFile( v )
		end
	end
	
end

function MODULE:Load()
	Ananke.MathsX.Initialise()
end


