Protocol = protocol.New()

Protocol:SetName( "Test" )
Protocol:SetPID( 0x01 )
Protocol:SetType( SERVER_TO_CLIENT )
Protocol:SetData( {[1] = 'string'} )

Protocol:SetCallBack( function(data)
	print(Data[1])
end )

Protocol:Register()
