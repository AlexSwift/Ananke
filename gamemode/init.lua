AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "core/core.lua")
AddCSLuaFile( "modules/modules.lua")
AddCSLuaFile( "extentions/extentions.lua" )

include('shared.lua')


function GM:PlayerSpawn( ply )
	-- Your code
	ply:SetupHands() -- Create the hands and call GM:PlayerSetHandsModel
end

-- Choose the model for hands according to their player model.
function GM:PlayerSetHandsModel( ply, ent )

	local simplemodel = player_manager.TranslateToPlayerModelName( ply:GetModel() )
	local info = player_manager.TranslatePlayerHands( simplemodel )
	if ( info ) then
		ent:SetModel( info.model )
		ent:SetSkin( info.skin )
		ent:SetBodyGroups( info.body )
	end

end