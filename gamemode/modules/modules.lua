modules = {}
modules.functions = {
	['init.lua'] = function(p)
		if !SERVER then return end
		include(p .. "/init.lua")
	end,
	['cl_init.lua'] = function(p)
		if SERVER then
			AddCSLuaFile(p .. '/cl_init.lua')
		else
			include(p .. "/cl_init.lua")
		end
	end}

function modules.Initialise()
	print('Loading modules:')
	local f,d = file.Find("gamemodes/wp_base/gamemode/modules/*", "GAME")
	for k,v in pairs(d) do
		print('\tLoaded module : ' .. v)
		for f,func in pairs(modules.functions) do
			if file.Exists('gamemodes/wp_base/gamemode/modules/'..v .. '/' .. f,'GAME') then
				func(v)
			end
		end
	end
end

modules.Initialise()

-- Will have to rewrite for use on dedi
