Ananke = GM --Where everything begins

Ananke.Name 	= "Ananke"
Ananke.Author 	= "TEAM WARPAC"
Ananke.Email 	= ""
Ananke.Website 	= ""

include('extentions/extentions.lua')
include('core/core.lua')
include('modules/modules.lua')
include('hooks/hooks.lua')

Ananke.core:IncludeDir( 'client', Ananke.Name .. '/gamemode/core/client' )
--Ananke.core:IncludeDir( 'client', Ananke.Name .. '/gamemode/core/client/menu' )
--Ananke.core:IncludeDir( 'client', Ananke.Name .. '/gamemode/core/client/menu/gui' )
Ananke.core:IncludeDir( 'shared', Ananke.Name .. '/gamemode/core/shared' )
Ananke.core:IncludeDir( 'server', Ananke.Name .. '/gamemode/core/server' )
