include('protocols.lua')

network = {}
network.__index = network

util.AddNetworkString('warpac_nw')

NW_STC 	= 0x01
NW_CTS 	= 0x02
NW_BOTH = 0x03
NW_CUSTOM = 0x04

function network.New()
	local nw 		= {}
	nw.Data 		= {}
	nw.protocol 	= {}
	nw.PID 			= 0x00
	nw.Recipients 	= nil
	nw.Description 	= ""

	return setmetatable(nw,network)
end

function network:SetProtocol(id)
	self.PID = id
	self.protocol = protocol.GetByID(id)
end

function network:SetDescription(str)
	self.Description = str
end

function network:PushData(data)

	if self.protocol.Data == NW_CUSTOM then
		self.Data[#self.Data + 0x01] = data
		return
	end

	local Datagram = self.protocol
	if Datagram.Data[#self.Data + 0x01] != type(data) then
		error('Data type MisMatch : ' .. self.Description)
	end
	self.Data[#self.Data + 0x01] = data
end

function network:Send()
	net.Start('warpac_nw')
		net.WriteInt(self.PID,0x10)
		if self.protocol.send then
			self.protocol.send(self.Data)
		else
			PrintTable(self)
			for k,v in ipairs(self.Data) do
				net['Write'..self.Protocol[k]](v)
			end
		end

	net.Send()
	return
end

net.Receive('warpac_nw',function()
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
