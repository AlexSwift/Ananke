Ananke = GM --Where everything begins

Ananke.Name 	= "Ananke"
Ananke.Author 	= "TEAM WARPAC"
Ananke.Email 	= ""
Ananke.Website 	= ""

include( 'core/core.lua' )
include( 'modules/modules.lua' )

Ananke.core:IncludeDir(  'shared', Ananke.Name .. '/gamemode/extentions', 0, 'Extentions' )
Ananke.core:IncludeDir(  'shared', Ananke.Name .. '/gamemode/core/shared', 0, 'Core' )
Ananke.core:IncludeDir(  'shared', Ananke.Name .. '/gamemode/core/shared/networking', 1, 'Core::Networking' )
Ananke.core:IncludeDir(  'shared', Ananke.Name .. '/gamemode/hooks', 0, 'Hooks' )

Ananke.core:AddCSLuaDir( Ananke.Name .. '/gamemode/core/client/gui' )
Ananke.core:IncludeDir(  'client', Ananke.Name .. '/gamemode/core/client' )

Ananke.core:IncludeDir(  'server', Ananke.Name .. '/gamemode/core/server' )

Ananke.core.Protocol:Initialize()			-- SHARED
Ananke.core.serialization.Initialize()		-- SHARED

if CLIENT then

	Ananke.core.Menu:Initialize()			-- CLIENT
	
end
	