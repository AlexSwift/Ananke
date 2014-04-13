Protocol = Ananke.core.Protocol.new()

Protocol:SetName( "ananke_setup_modules" )
Protocol:SetPID( 0x05 )
Protocol:SetType( SERVER_TO_CLIENT )
Protocol:SetData( {
	[1] = 'string',
	[2] = 'table'
} )

Protocol:SetCallBack( function(data)
	print( 'hmmmmmmm' )
	if not Ananke._MODULES[ data[1] ] then
		Ananke._MODULES[ data[1] ] = Ananke._MODULES[ data[1] ] or {}
	end
	Ananke._MODULES[ data[1] ].INI = data[2]
	Ananke.Modules:LoadModule( data[1] )
end )

Protocol:Register()