Protocol = protocol.New()

Protocol.Name = "Profiles"
Protocol.PID  = 0x03
Protocol.Type = NW_STC
Protocol.Data = NW_CUSTOM

Protocol.CallBack = function(data)
	profiles.GetByID(data[1]):Set(data[2],data[3])
end

Protocol.send = function(data)

	net.WriteUInt(data[1])
	net.WriteString(data[2])
	net.WriteString(data[3])
	net['Write'..NW_TRANSLATIONS[data[3]]()](data[4])

end

protocol.receive = function()

	local data = {}

	data[1] = net.ReadUInt()
	data[2] = net.ReadString()
	data[3] = net['Read'..net.ReadString()]()

	return data
end

Protocol:Register()
