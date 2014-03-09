MODULE.Name = 'Factions'
MODULE.Author = 'Ananke TEAM'
MODULE.Contact = ''
MODULE.Website = ''
MODULE.Description = ''

function MODULE:Load()

	Protocol = Ananke.core.protocol.new()
	
	Protocol:SetName( "nw_factions" )
	Protocol:SetPID( 0x02 )
	Protocol:SetType( NW_STC )		--0x01 - Server to Client
	Protocol:SetData( NW_CUSTOM ) 	--Custom Datagram. Variables won't all be of same type.
	
	Protocol:SetCallBack( function(data)
		-- self:SetData( resource , amount )
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

end