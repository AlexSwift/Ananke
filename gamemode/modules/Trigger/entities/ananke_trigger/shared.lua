AddCSLuaFile( )

ENT.Name		= 'ananke_trigger'
ENT.Author		= 'Alex Swift'
ENT.Contact		= 'WARPAC DevTeam'
ENT.Type 		= 'base_brush'

local TRIGGER = Ananke.Modules:Get( 'Trigger' )

function ENT:StartTouch( ent )

	TRIGGER.Functions.StartTouch( self, ent )

end

function ENT:EndTouch( ent )

	TRIGGER.Functions.EndTouch( self, ent )

end