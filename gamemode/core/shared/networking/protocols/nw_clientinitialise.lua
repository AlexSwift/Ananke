Protocol = Ananke.core.protocol.new()

Protocol:SetName( "ananke_clientinitalise_1" )
Protocol:SetPID( 0x04 )
Protocol:SetType( CLIENT_TO_SERVER )
Protocol:SetData( {[1] = 'number'} )

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

if CLIENT then
	hook.Add( 'Initialize' , 'Ananke:SetupModules' , function()
		local nw = network.New()
		nw:SetProtocol(0x04)
		nw:SetDescription('Client Initialize')
		nw:PushData( time() )
		nw:Send()
	end)
end

---------------------------------------------------------


Protocol = Ananke.core.protocol.new()

Protocol:SetName( "ananke_setup_modules" )
Protocol:SetPID( 0x05 )
Protocol:SetType( SERVER_TO_CLIENT )
Protocol:SetData( {
	[1] = 'string',
	[2] = 'string'
} )

Protocol:SetCallBack( function(data)
	Ananke._MODULES[ data[1] ]:SetINI( data[2] )
end )

Protocol:Register()
