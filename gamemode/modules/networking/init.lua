AddCSLuaFile('protocols.lua')
AddCSLuaFile('cl_init.lua')

include('protocols.lua')

network = {}
network.__index = network

util.AddNetworkString('warpac_nw')

function network.New()
	local nw 		= {}
	nw.Data 		= {}
	nw.Protocol 	= {}
	nw.PID 			= 0x00
	nw.Recipients 	= nil
	nw.Description 	= ""

	return setmetatable(nw,network)
end

function network:SetProtocol(id)
	self.protocol = protocol.GetByID(id)
end

function network:SetDescription(str)
	self.Description = str
end

function network:SetRecipients(...)
	self.Recipients = {...}[1]
end

function network:PushData(data)
	if self.Data == NW_CUSTOM then return end
	local Datagram = self.Protocol
	if Datagram.Data[#self.Data + 1] != type(data) then
		error('Data type MisMatch : ' .. self.Description)
	end
	self.Data[#self.Data + 1] = Data
end

function network:Send()
	net.Start('warpac_nw')
		if self.Send then
			net.WriteInt(self.PID)
			self.Send()
		else
			net.WriteInt(self.PID)
			for k,v in ipairs(self.Data) do
				net['Write'..self.Protocol[k]](v)
			end
		end

	if self.Recipiants then
		net.Send(self.Recipiants)
		self = nil
		return
	end

	net.Send()
	self = nil
	return
end

net.Recieve('warpac_nw',function()
	local PID = net.ReadInt()
	local Datagram = protocol.GetByID(PID)
	local data = {}
	if Datagram.Type == NW_CUSTOM then
		data = Datagram.Receive()
	else
		for k,v in ipairs(Datagram.Data) do
			table.insert( data , net['Read'..v] )
		end
	end
	Datagram.Callback(data)

	PID = nil
	Datagram = nil
	data = nil

	return

end)
