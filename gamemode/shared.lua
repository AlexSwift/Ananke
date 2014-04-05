Ananke = GM --Where everything begins

Ananke.Name 	= "Ananke"
Ananke.Author 	= "TEAM WARPAC"
Ananke.Email 	= ""
Ananke.Website 	= ""

include( 'extentions/extentions.lua' )
include( 'core/core.lua' )
include( 'modules/modules.lua' )

function Ananke.Initialise()

	--Ananke.core:IncludeDir(  'shared', 'extentions', 0, 'Extentions' )
	Ananke.core:IncludeDir(  'shared', 'core/shared', 0, 'Core' )
	Ananke.core:IncludeDir(  'shared', 'core/shared/networking', 1, 'Core::Networking' )
	Ananke.core:IncludeDir(  'shared', '/hooks', 0, 'Hooks' )

	Ananke.core:AddCSLuaDir( 'core/client/gui' )
	Ananke.core:IncludeDir(  'client', '/core/client' )

	Ananke.core:IncludeDir(  'server', '/core/server' )

	Ananke.core.Protocol:Initialize()			-- SHARED
	Ananke.core.serialization.Initialize()		-- SHARED

	if CLIENT then

		Ananke.core.Menu:Initialize()			-- CLIENT
		
	end

end
	