Protocol = Ananke.core.Protocol.new()

Protocol:SetName( "Profiles" )
Protocol:SetPID( 0x03 )
Protocol:SetType( NW_STC )
Protocol:SetData( NW_CUSTOM )

Protocol:SetCallBack( function(data)
	profiles.GetByID(data[1]):Set(data[2],data[3])
end )

Protocol:SetSend( function(data)

	net.WriteUInt(data[1])
	net.WriteString(data[2])
	net.WriteString(data[3])
	net['Write'..NW_TRANSLATIONS[data[3]]()](data[4])

end )

Protocol:SetReceive( function()

	local data = {}

	data[1] = net.ReadUInt()
	data[2] = net.ReadString()
	data[3] = net['Read'..net.ReadString()]()

	return data
end )

Protocol:Register()
