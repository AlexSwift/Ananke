protocol = {}
protocol.__index = protocol
protocol.Loaded = false


_PROTOCOLS = {}

function protocol.New()
	local tabl = {}
	return setmetatable(tabl,table.Copy(protocol))
end

function protocol:Register()
	_PROTOCOLS[self.PID] = table.Copy(self)
end

function protocol.GetByID(id)
	return _PROTOCOLS[id]
end

function protocol.Initialise()
	if protocol.Loaded then return end
	local prefix = CLIENT and "lua_temp" or "gamemodes/wp_base/gamemode"

	local f,d = file.Find( prefix .. "/core/shared/protocols/*.lua", "GAME" )

	print('\tLoading Protocols:')

	for k,v in pairs(f) do
		if SERVER then
			print('\t\tLoading ' .. v)
			do
				AddCSLuaFile('wp_base/gamemode/core/shared/protocols/'..v)
				include('wp_base/gamemode/core/shared/protocols/'..v)
			end
		else
			print('\t\tLoading ' .. v)
			do
				include('wp_base/gamemode/core/shared/protocols/'..v)
			end
		end
	end
	protocol.Loaded = true
end

