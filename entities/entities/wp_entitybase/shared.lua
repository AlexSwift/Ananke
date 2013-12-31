ENT.Name			= "wp_entitybase"
ENT.Author			= "Alex Swift, WARPAC Team"
ENT.Contact			= ""
ENT.Base 			= "base_entity"
ENT.Type 			= "anim"
ENT.Spawnable 		= false
ENT.AdminOnly 		= false
ENT.GVars			= {}

function table.HVIST(tabl,v,k)
	for key,value in pairs(tabl) do
		if value[k] == v then
			return true
		end
	end
	return false
end

ENT.__index = function(self,k)
	if string.sub(k,1,3) == "Set" and table.HVIST(self.GVars,1,k) then
		local func = function(self,v,...)
			local args = {...}
			local b_nw = args[1] or false
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
	if string.sub(k,1,3) == "Get" and table.HVIST(self.GVars,1,k) then
		local func = function(self)
			return self[string.sub(k,4)]
		end
		return func
	end
	return self
end

ENT.__newindex = function(self,k,v)
	for k,v in pairs(self.GVars) do
		if v[1] == k then
			local nw = network.New()
			nw:SetProtocol(0x04)
			nw:SetDescription('Automatic accessor variables netowkring')
			nw:PushData(self:EntIndex())
			nw:PushData(k)
			nw:PushData(type(v))
			nw:PushData(v)
			nw:Send()
			self[k] = v
			return
		else
			continue
		end
	end
	self[k] = v
	return
end

function ENT:AddGVar( name , ... ) -- name, default, b_nw
	local args = {...}
	table.insert( self.GVars , { name, unpack(args) } )
end


function ENT:Initialize()

	hook.Add( 'PlayerInitialSpawn' , 'wp_gvnw_' .. self:EntIndex() , function(ply)
		for k,v in pairs(ENT.GVars) do
			local default = v[2] or 0
			local b_nw = v[3]

			if v[3] != true then continue end

			local nw = network.New()
				nw:SetProtocol(0x04)
				nw:SetDescription('Automatic accessor variables netowkring')
				nw:SetRecipient(ply)
				nw:PushData(self:EntIndex())
				nw:PushData(v[1])
				nw:PushData(type(default))
				nw:PushData(default)
			nw:Send()
		end

	end )

end

