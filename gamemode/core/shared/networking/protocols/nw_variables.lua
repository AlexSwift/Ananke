Protocol = protocol.New()

Protocol:SetName( "nw_variables" )
Protocol:SetPID( 0x02 )
Protocol:SetType( NW_STC )		--0x01 - Server to Client
Protocol:SetData( NW_CUSTOM ) 	--Custom Datagram. Variables won't all be of same type.

Protocol:SetCallBack( function(data)
	for k,v in pairs(data) do
		variables[k] = v
	end
end )

Protocol:SetSend( function(data)
	net.WriteString(data[1])
	net.WriteString(data[2])
	net['Write' .. data[2]](data[3])
end)

Protocol:SetReceive( function()
	local key = net.ReadString()
	local value = net['Read'..net.ReadString()]()

	return { [key] = value }
end)

Protocol:Register()


variables =  SERVER and setmetatable({},{
	__index = function(t,k) end,
	__newindex = function(t,k,v)
		local nw = network.New()
		nw:SetProtocol(0x02)
		nw:SetDescription('Automatic variable networking')
		nw:PushData(k)
		nw:PushData(type(v))
		nw:PushData(v)
	nw:Send()
	end}) or {}

