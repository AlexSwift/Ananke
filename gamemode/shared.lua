Ananke = GM --Where everything begins

Ananke.Name 	= "Ananke"
Ananke.Author 	= "TEAM WARPAC"
Ananke.Email 	= ""
Ananke.Website 	= ""

include( 'extentions/extentions.lua' )
include( 'core/core.lua' )
include( 'modules/modules.lua' )

function Ananke.Initialise()

	Ananke.core:SetDirectory( 'Ananke/gamemode' )

	Ananke.core:IncludeDir(  'Shared', 'core/shared', 0, 'Core::Shared' )
	Ananke.core:IncludeDir(  'Shared', 'core/shared/networking', 1, 'Core::Shared::Networking' )
	Ananke.core:IncludeDir(  'Shared', 'hooks', 0, 'Hooks' )

	Ananke.core:AddCSLuaDir( 'core/client/gui' )
	Ananke.core:IncludeDir(  'Client', 'core/client', 0 , 'Core::Client' )

	Ananke.core:IncludeDir(  'Server', 'core/server', 0 , 'Core::Server' )

	Ananke.core.Protocol:Initialize()			-- SHARED
	Ananke.core.serialization:Initialize()		-- SHARED

	if CLIENT then

		Ananke.core.Menu:Initialize()			-- CLIENT
		
	end

end
	