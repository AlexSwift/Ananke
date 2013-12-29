Protocol = protocol.New()

Protocol.Name = "Profiles"
Protocol.PID  = 0x03
Protocol.Type = NW_STC
Protocol.Data = NW_CUSTOM

Protocol.CallBack = function(data)

end

Protocol.send = function(data)

end

protocol.receive = function()

	return data
end

Protocol:Register()
