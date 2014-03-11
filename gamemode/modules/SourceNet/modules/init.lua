--[[

	SOURCENET3
	
Welcome to my crib. where Ananke takes things
just that step further, exposing functions that
developers would only have in their wet dreams.

I must issue a caution however, the misuse of 
these functions will cause horrible errors on the
server. If you are trying to send a message, and if
the DefaultCopy function does not properly copy
what would normally be copied in the generic 
CNetProcess::SendDatagram( &bf_read ), then prepare 
yourself for a hard time fixing these issues.

Do not change the DefaultCopy functions, always create
Filter messages. Functions will be exposed for this.


That is all --Alex

]]--

include( 'base/sn3_base_netmessages.lua' )
include( 'base/sn3_base_querycvar.lua' )

-- include( 'base/sn3_base_gameevents.lua' ) --This does not work!

local _QueryCheck = { 
	['CheatsCookie'] = 'sv_cheats'
	}

function FindPlayerByNetChannel( netchan )
	local adr = netchan:GetAddress():ToString()

	for k, v in pairs( player.GetAll() ) do
		if ( adr == v:IPAddress() ) then
			return v
		end
	end
end

hook.Add( "PlayerInitialSpawn", "InitialCheatsCheck", function( ply )
	for k,v in pairs( _QueryCheck ) do	
		ply[k] = ply:QueryConVarValue( v )
	end
end )

hook.Add( "RespondCvarValue", "InitialCheatsCheck", function( netchan, cookie, status, cvarname, cvarvalue )
	if ( status != 0 ) then return end
	local procceed = false
	local cvarcookie = nil
	for k,v in pairs( _QueryCheck ) do
		if cvarname != v then
			continue
		else
			procceed = true
			cvarcookie = ply[k]
		end
	end
	
	if not procceed then return end
	
	if ( cvarvalue == GetConVarString( cvarname ) ) then return end
	
	local ply = FindPlayerByNetChannel( netchan )
	
	if ( ValidEntity( ply ) and cookie == cvarcookie ) then
		ply:Kick( "Incorrect cvar value " .. cvarname )
	end
end )