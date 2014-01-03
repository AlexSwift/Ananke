modules = {}
modules.__index = {}

local _MODULES = {}

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

function modules.new()
	return setmetatable( { } , modules )
end

function modules:Register()
	_MODULES[self.name] = table.Copy(self)
end

function modules.get( name )
	return _MODULES[name]
end

function modules:OnLoad ( )

end

function modules:UnLoad( )

end

function modules.Load( ... )
	local args = {...}
	if type(args[1]) == 'table' then
		for k,v in pairs(args[1]) do
			print('\tLoaded module : ' .. v)
			for f,func in pairs(modules.functions) do
				if file.Exists('gamemodes/wp_base/gamemode/modules/'..v .. '/' .. f,'GAME') and file.Size('gamemodes/wp_base/gamemode/modules/'..v .. '/' .. f,"GAME") != 0 then
					func(v)
				end
			end
			modules.get( args[1] ):OnLoad()
		end
	else
		print('\tLoaded module : ' .. v)
		for f,func in pairs(modules.functions) do
			if file.Exists('gamemodes/wp_base/gamemode/modules/' ..args[1] .. '/' .. f,'GAME') and file.Size('gamemodes/wp_base/gamemode/modules/'..args[1] .. '/' .. f,"GAME") != 0 then
				func(args[1])
			end
		end
		modules.get( args[1] ):OnLoad()
	end
end

function modules.Unload( name )
	modules.get( name ):UnLoad()
end

function modules.Initialise()
	for k,v in pairs(_MODULES) do
		modules.get( k ):OnLoad()
	end
end


-- Will have to rewrite for use on dedi
