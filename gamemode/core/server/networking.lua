util.AddNetworkString('ananke_nw')

class 'Ananke.Network' {

	private {
	
		Data 			= {};
		protocol 		= {};
		PID 			= 0x00;
		Recipients 		= nil;
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
		
			net.Start('ananke_nw')
			
				net.WriteInt(self.PID,0x10)
				if self.protocol.send != null then
					self.protocol.send(self.Data)
				else
					for k,v in ipairs(self.Data) do
						net['Write'..NW_TRANSLAITON[type(v)]()](v)
					end
				end
		
				if self.Recipiants then
					net.Send(self.Recipiants)
					return
				end
				
				print( 'Sending MSG ' )
				PrintTable( self.Data )
		
			net.Send()
		
			return
		end;
				
	};

}
