modules = {}
modules.__index = {}
modules.mt = {}
modules.mt.__index = {}

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
	return setmetatable( modules.mt , modules.mt )
end

function modules.mt:Register()
	_MODULES[self.name] = self
end

function modules.get( name )
	return _MODULES[name]
end

function modules.mt:OnLoad ( )

end

function modules.mt:UnLoad( )

end

function table.HasKey( tabl , key )
	for k,v in pairs(tabl) do
		if k == key then return true end
		continue
	end
	return false
end

function modules.Load( ... )
	print( 'Loading Modules' )
	local args = {...}
	if type(args[1]) == 'table' then
		for k,v in pairs(args[1]) do
			print('\tLoaded module : ' .. v)
			for f,func in pairs(modules.functions) do
				if file.Exists('gamemodes/wp_base/gamemode/modules/'..v .. '/' .. f,'GAME') and file.Size('gamemodes/wp_base/gamemode/modules/'..v .. '/' .. f,"GAME") != 0 then
					do
						func("wp_base/gamemode/modules/"..v)
					end
				end
			end
		end
	else
		if !table.HasKey( _MODULES , args[1] ) then return end
		print('\tLoaded module : ' .. args[1])
		for f,func in pairs(modules.functions) do
			if file.Exists('gamemodes/wp_base/gamemode/modules/' ..args[1] .. '/' .. f,'GAME') and file.Size('gamemodes/wp_base/gamemode/modules/'..args[1] .. '/' .. f,"GAME") != 0 then
				do
					func( "wp_base/gamemode/modules/"..args[1])
				end
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
