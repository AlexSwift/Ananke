
function profiles.New()
	return setmetatable({},table.Copy(profiles))
end

function profiles:SetOwner(ply)
	self.Owner = ply
end

function profiles:Set(key,value,...)
	if !profiles['types'][key] then return end
	local args = {...} --Send,SendToAll
	self['data'][key] = value

	if !args[1] then return end

	local rf = args[2] and player.GetAll() or self.Owner
	self:Network(rf)
end

function profiles:Network(rf)
	local rf = rf and rf or self.Owner
	for k,v in pairs(self['data']) do
		local nw = network.New()
		nw:SetProtocol(0x03)
		nw:SetDescription('Sending player variables')
		nw:SetRecipients(rf)
		nw:PushData(self.Owner:EntIndex())
		nw:PushData(key)
		nw:PushData(type(value))
		nw:PushData(value)
		nw:Send()
	end
end

function profiles:Get(key)
	if !profiles['types'][key] then return end
	return self['data'][key] or nil
end

function profiles:Load(id,...)
	local args = {...}
	local q = "SELECT * WHERE `id` = `" .. id .. "`;"
	core.MySQL.Query( q, function(data)
		local d = core.serialization.decode(data[1])
		for k,v in pairs(d) do
			self:Set(k,v,unpack(args))
		end
	end)
	self.ID = id
end

function profiles:Save()

	local s_data = core.serialization.encode(self['data'])

	local q = "UPDATE 'wp_profiles' SET `s_data`=`" .. s_data .. "` WHERE `id` =`" .. self.ID .."`;"
	core.MySQL.Query( q )

end

function profiles.LoadPlayer(ply)
	local profile = profiles.New()
	profile:Load(ply:SteamID())
	profile:SetOwner(ply)
	profile:Network()

	profile = nil

end

