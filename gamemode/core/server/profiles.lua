
function Ananke.core.profiles.New()
	return setmetatable({},table.Copy(Ananke.core.profiles))
end

function Ananke.core.profiles:SetOwner(ply)
	self.Owner = ply
end

function Ananke.core.profiles:Set(key,value,...)
	if !Ananke.core.profiles['types'][key] then return end
	local args = {...} --Send,SendToAll
	self['data'][key] = value

	if !args[1] then return end

	local rf = args[2] and player.GetAll() or self.Owner
	self:Network(rf)
end

function Ananke.core.profiles:Network(rf)
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

function Ananke.core.profiles:Get(key)
	if !Ananke.core.profiles['types'][key] then return end
	return self['data'][key] or nil
end

function profiles:Load(id,...)
	local args = {...}
	local q = "SELECT * WHERE `id` = `" .. id .. "`;"
	core.MySQL.Query( q, function(data)
		local d = Ananke.core.serialization.decode(data[1])
		for k,v in pairs(d) do
			self:Set(k,v,unpack(args))
		end
	end)
	self.ID = id
end

function Ananke.core.profiles:Save()

	local s_data = Ananke.core.serialization.encode(self['data'])

	local q = "UPDATE 'wp_profiles' SET `s_data`=`" .. s_data .. "` WHERE `id` =`" .. self.ID .."`;"
	Ananke.core.MySQL.Query( q )

end

function Ananke.core.profiles.LoadPlayer(ply)
	local profile = Ananke.core.profiles.New()
	profile:Load(ply:SteamID())
	profile:SetOwner(ply)
	profile:Network()

	profile = nil

end

