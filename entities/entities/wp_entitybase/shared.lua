ENT.Name			= "wp_entitybase"
ENT.Author			= "Alex Swift, WARPAC Team"
ENT.Contact			= ""
ENT.Base 			= "base_entity"
ENT.Type 			= "anim"
ENT.Spawnable 		= false
ENT.AdminOnly 		= false
ENT.GVars			= {}

ENT.__index = function(self,k)
	if string.sub(k,1,3) == "Set" then
		local func = function(self,v,...)
			local b_nw = {...}[1] or false
			self[string.sub(k,4)] = v
			if SERVER and b_nw then
				local nw = network.New()
				nw:SetProtocol(0x04)
				nw:SetDescription('Automatic accessor variables netowkring')
				nw:PushData(self:EntIndex())
				nw:PushData(k)
				nw:PushData(type(v))
				nw:PushData(v)
				nw:Send()
			end
		end
		return func
	end
	if string.sub(k,1,3) == "Get" then
		local func = function(self)
			return self[string.sub(k,4)]
		end
		return func
	end
	return self
end

function ENT:AddGVar( name , ... )
	local args = {...}
	table.insert( self.GVars , { name, args[1] } )
end

function ENT:Initialize()

	hook.Add( 'PlayerInitialSpawn' , 'wp_gvnw_' .. self:EntIndex() , function(ply)
		for k,v in pairs(ENT.GVars) do
			local nw = network.New()
			nw:SetProtocol(0x04)
			nw:SetDescription('Automatic accessor variables netowkring')
			nw:SetRecipient(ply)
			nw:PushData(self:EntIndex())
			nw:PushData(v[1])
			nw:PushData(type(v[2]))
			nw:PushData(v[2])
			nw:Send()
	end)

end

