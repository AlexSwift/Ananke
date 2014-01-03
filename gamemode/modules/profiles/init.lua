include('shared.lua')

AddCSLuaFile('shared.lua')

function profiles.New()
	return setmetatable({},table.Copy(profiles))
end

function profiles:SetOwner(ply)
	self.Owner = ply
end

function profiles:Set(key,value,...)
	local args = {...} --Send,SendToAll
	self[key] = value

	if !args[1] then return end

	local rf = args[2] and player.GetAll() or self.Owner
	local nw = network.New()
	nw:SetProtocol(0x03)
	nw:SetDescription('Sending player variables')
	nw:SetRecipients(rf)
	nw:PushData(self.Owner:EntIndex())
	nw:PushData(key)
	nw:PushData(type(v))
	nw:PushData(v)
	nw:Send()
end

function profiles:Get(key)
	return self[key] or nil
end

function profiles:Load(id,...)
	local args = {...}
	local q = "SELECT * WHERE `id` =" .. id
	core.MySQL.Query( q, function(data)
		for k,v in pairs(data[1]) do
			self:Set(k,v,unpack(args))
		end
	end)
end

function profiles:Save()

end
