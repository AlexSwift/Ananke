util.AddNetworkString('ananke_nw')

net.Receive('ananke_nw',function()

	print( 'Messaged Received SERVER' )

	local Datagram = Ananke.core.Protocol:GetByID( net.ReadInt(16) )
	local data = {}
	
	if Datagram.Type == NW_CUSTOM then
		data = Datagram.Receive()
	else
		for k,v in ipairs(Datagram.Data) do
			table.insert( data , net['Read'..NW_TRANSLAITON[v]()]() )
		end
	end

	
	Datagram:GetCallBack()(data)
	
	return

end)