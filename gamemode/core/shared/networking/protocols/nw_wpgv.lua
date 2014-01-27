
Protocol = protocol.New()

Protocol:SetName( "nw_wpgv" )
Protocol:SetPID ( 0x04 )
Protocol:SetType( NW_STC )		--0x01 - Server to Client
Protocol:SetData( NW_CUSTOM )	--Custom Datagram. Variables won't all be of same type.

Protocol:SetCallBack( function(data)
	local ent = Entity(data[1])
	ent[data[2]] = data[3]
end )

Protocol:SetSend( function(data)
	net.WriteUInt(data[1])
	net.WriteString(data[2])
	net['Write' .. data[2]](data[3])
end )

Protocol:SetReceive( function()
	local id = net.ReadUInt()
	local key = net.ReadString()
	local value = net['Read'..net.ReadString()]()

	return { id , key , value }
end )

Protocol:Register()


