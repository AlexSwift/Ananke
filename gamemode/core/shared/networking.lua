if SERVER then
	AddCSLuaFile("networking/enumerations.lua")
	AddCSLuaFile("networking/protocols.lua")
end
Ananke.include( Ananke.Name .. "/gamemode/core/shared/networking/enumerations.lua")
Ananke.include( Ananke.Name .. "/gamemode/core/shared/networking/protocols.lua" )