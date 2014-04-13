Ananke.MathsX = {}

function Ananke.MathsX.Initialise()

	local f,d = file.Find( Ananke.Name .. "/gamemode/modules/MathsX/module/*.lua", "LUA" )

	print('\t\tLoading MathsX Extentions :')
	
	for k,v in pairs(f) do
		if v == 'mathsx.lua' then continue end
		print('\t\t\tLoading ' .. v)
		Ananke.include( Ananke.Name .. '/gamemode/modules/MathsX/module/' .. v )
		if SERVER then 
			Ananke.AddCSLuaFile( Ananke.Name .. '/gamemode/modules/MathsX/module/' .. v )
		end
	end
	
end

function MODULE:Load()
	Ananke.MathsX.Initialise()
end


