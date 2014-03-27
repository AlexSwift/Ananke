AddCSLuaFile( )

ENT.Name		= 'ananke_trigger'
ENT.Author		= 'Alex Swift'
ENT.Contact		= 'WARPAC DevTeam'
ENT.Type 		= 'base_brush'

function ENT:StartTouch( ent )

	Ananke.Trigger.StartTouch( self, ent )

end

function ENT:EndTouch( ent )

	Ananke.Trigger.EndTouch( self, ent )

end