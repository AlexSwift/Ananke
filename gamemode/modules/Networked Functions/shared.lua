local modul = Ananke.modules.new()
modul.Name = 'NwFuncs'

newfuncs = {}

function nwfuncs.Initialise()
	
end

function modul:Load()
	nwfuncs.Initialise()
end

include("chataddtext.lua")




modul:Register()
