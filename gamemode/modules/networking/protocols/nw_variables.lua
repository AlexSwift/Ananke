Protocol = protocol.New()

Protocol.Name = "nw_variables"
Protocol.PID  = 0x02
Protocol.Type = NW_STC 		--0x01 - Server to Client
Protocol.Data = NW_CUSTOM 	--Custom Datagram. Variables won't all be of same type.

Protocol.CallBack = function(data)
	for k,v in pairs(data) do
		variables[k] = v
	end
end

Protocol.Send = function(data)
	net.WriteString(data[1])
	net.WriteString(data[2])
	net['Write' .. data[2]](data[3])
end

Protocol.Receive = function()
	local key = net.ReadString()
	local value = net['Read'..net.ReadString()]()

	return { [key] = value }
end

Protocol:Register()
