Protocol = Ananke.core.Protocol.new()

Protocol:SetName( "ananke_clientinitalise_1" )
Protocol:SetPID( 0x04 )
Protocol:SetType( CLIENT_TO_SERVER )
Protocol:SetData( {[1] = 'string'} )

Protocol:SetCallBack( function(data)
	
	for k,v in pairs( Ananke._MODULES ) do
		local nw = Ananke.Network.new()
		nw:SetProtocol(0x05)
		nw:SetDescription('Client Initialize')
		nw:PushData( k )
		nw:PushData( v:GetINI() )
		nw:Send()
	end
	
end )

Protocol:Register()

