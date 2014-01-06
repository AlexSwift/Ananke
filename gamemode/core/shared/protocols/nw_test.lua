Protocol = protocol.New()

Protocol.Name = "Test"
Protocol.PID  = 0x01
Protocol.Type = SERVER_TO_CLIENT
Protocol.Data = {[1] = 'string'}

Protocol.CallBack = function(data)
	print(Data[1])
end

Protocol:Register()
