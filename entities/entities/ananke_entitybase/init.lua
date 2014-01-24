AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

function ENT:UpdateTransmitState()
	return TRANSMIT_PVS
end

function ENT:Think()

end

function ENT:Initialize()

end
