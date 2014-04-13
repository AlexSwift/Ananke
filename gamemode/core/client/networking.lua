class 'Ananke.Network' {

	private {
	
		Data 			= {};
		protocol 		= {};
		PID 			= 0x00;
		Description 	= ""
		
	};

	public {
	
		SetProtocol = function( self , id )
			self.PID = id
			self.protocol = Ananke.core.Protocol:GetByID(id)
		end;
		
		SetDescription = function( self, str )	
			self.Description = str
		end;
		
		SetRecipients = function( self , rp )
			self.Recipients = rp
		end;
		
		PushData = function( self , data )
			if self.protocol:GetData() == NW_CUSTOM then
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
		
				net.Start('ananke_nw')
			
					print( 'Sending Message: Client' )
					
					net.WriteInt(self.PID,0x10)
					if self.protocol:GetSend() != null then
						self.protocol.send(self.Data)
					else
						for k,v in ipairs(self.Data) do
							net['Write' .. NW_TRANSLAITON[type(v)]() ](v)
						end
					end
					
					print( 'Message Sent' )
			
				net.SendToServer()
		end;
				
	};
	
}