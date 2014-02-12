util.AddNetworkString('warpac_nw')

class 'network' {

	public {
	
		SetProtocol = function( self , id )
			self.PID = id
			self.protocol = Ananke.core.protocol.GetByID(id)
		end;
		
		SetDescription = function( self, str )	
			self.Description = str
		end;
		
		SetRecipients = function( self , rp )
			self.Recipients = rp
		end;
		
		PushData = function( self , data )
			if self.protocol.Data == NW_CUSTOM then
				self.Data[#self.Data + 0x01] = data
				return
			end

			local Datagram = self.protocol
			if Datagram.Data[#self.Data + 0x01] != type(data) then
				error('Data type MisMatch : ' .. self.Description)
			end
			self.Data[#self.Data + 0x01] = data
		end;
		
		Send = function( self )
			net.Start('warpac_nw')
				net.WriteInt(self.PID,0x10)
				if self.protocol.send then
					self.protocol.send(self.Data)
				else
					PrintTable(self)
					for k,v in ipairs(self.Data) do
						net['Write'..NW_TRANSLAITON[type(v)]()](v)
					end
				end
		
				if self.Recipiants then
					net.Send(self.Recipiants)
					return
				end
		
			net.Send()
		
			return
		end;
				
	};
	private {
		Data 			= {};
		protocol 		= {};
		PID 			= 0x00;
		Recipients 		= nil;
		Description 	= ""
	}
}

net.Receive('warpac_nw',function()
	local Datagram = Ananke.core.protocol.GetByID( net.ReadInt() )
	local data = {}
	
	if Datagram.Type == NW_CUSTOM then
		data = Datagram.Receive()
	else
		for k,v in ipairs(Datagram.Data) do
			table.insert( data , net['Read'..NW_TRANSLAITON[v]()]() )
		end
	end
	
	Datagram:GetCallBack()(data)

end)

Ananke.core.protocols.Initialise()

