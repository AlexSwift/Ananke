Ananke.Hooks = {}

function Ananke.Hooks.Initialise()

	f,d = file.Find( Ananke.Name .. "/gamemode/hooks/*.lua", "LUA" )

	print('Loading Hooks :')
	for k,v in pairs(f) do
		if v == 'hooks.lua' then continue end
		print('\tLoading ' .. v)
		Ananke.include( Ananke.Name .. "/gamemode/hooks/" .. v )
		if SERVER then 
			Ananke.AddCSLuaFile( v )
		end
	end


end

Ananke.Hooks.Initialise()

