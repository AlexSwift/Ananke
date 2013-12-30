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
				nw:PushData(self) --Is this Efficient?
				nw:PushData(k)
				nw:PushData(type(v))
				nw:PushData(v)
				nw:Send() --Looks like protocol 0x03 for variables
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

function ENT:AddGVar( name , ... ) --GVar name , {...}[1] Auto Network?
	local args = {...}
	table.insert( self.GVars , { name, args[1] } )
end

hook.Add( 'PlayerInitialSpawn' , 'wp_gvnw' , function(ply)
	-- Network current vars here
end)

