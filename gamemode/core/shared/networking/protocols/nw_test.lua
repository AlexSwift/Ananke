Protocol = Ananke.core.Protocol.new()

Protocol:SetName( "Test" )
Protocol:SetPID( 0x01 )
Protocol:SetType( SERVER_TO_CLIENT )
Protocol:SetData( {[1] = 'string'} )

Protocol:SetCallBack( function(data)
	print(data[1])
end )

Protocol:Register()
