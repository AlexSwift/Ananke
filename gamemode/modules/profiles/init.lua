profiles = {}
profiles.__index = profiles

function profiles.New()
	return setmetatable({},profiles)
end

function profiles:SetOwner(ply)
	self.Owner = ply
end

function profiles:Set(key,value,SendToAll)
	self[key] = value
	local rf = SendToAll and player.GetAll() or self.Owner

	local nw = network.New()
	nw:SetProtocol(0x03)
	nw:SetDescription('Sending player variables')
	nw:SetRecipients(rf)
	nw:PushData(key)
	nw:PushData(type(v))
	nw:PushData(v)
	nw:Send()
end

function profiles:Get(key)
	return self[key] or nil
end

function profiles:Load(id,SendToAll)
	local q = "SELECT * WHERE `id` =" .. id
	core.MySQL.Query( q, function(data)
		for k,v in pairs(data[1]) do
			self:Set(k,v,SendToAll)
		end
	end)
end

function profiles:Save()

end
