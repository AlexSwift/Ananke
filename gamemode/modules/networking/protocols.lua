protocol = {}
protocol.__index = protocol


_PROTOCOLS = {}

function protocol.New()
	local tabl = {}
	return setmetatable(tabl.protocol)
end

function protocol:Register()
	_PROTOCOLS[self.PID] = table.copy(self)
	self = nil
	end
end

function protocol.GetByID(id)
	return _PROTOCOLS[id]
end

function protocol.Initialise()

	local prefix = CLIENT and "lua_temp" or "gamemodes/wp_base/gamemode"

	local f,d = file.Find( prefix .. "/modules/networking/protocols/*.lua", "GAME" )

	print('\tLoading Protocols:')

	for k,v in pairs(f) do
		if SERVER then
			print('\t\tLoading ' .. v)
			AddCSLuaFile(v)
			include(v)
		else
			print('\t\tLoading ' .. v)
			include(v)
		end
	end
end


protocol.Initialise() --Load all modules.
