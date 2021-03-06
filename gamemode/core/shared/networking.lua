class 'Ananke.core.Network_shared' {

	private {
	
		Data 			= {}; --Stack = util.Stack()
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
			if self.protocol.Data == NW_CUSTOM then
				self.Data[#self.Data + 0x01] = data
				--self.Stack:Push( data )
				return
			end

			local Datagram = self.protocol
			
			if Datagram.Data[#self.Data + 0x01] != type(data) then
				-- stack problem with stack count
				error('Data type MisMatch : ' .. self.Description)
			end
			self.Data[#self.Data + 0x01] = data
			--self.Stack:Push( data )
		end;
		
		Receive = function( )
		
			local Datagram = Ananke.core.Protocol:GetByID( net.ReadInt( 0x20 ) )
			local data = {}
			
			if Datagram.Type == NW_CUSTOM then
				data = Datagram.Receive()
			else
				for k,v in ipairs(Datagram.Data) do
					table.insert( data , net['Read'..NW_TRANSLAITON[v]()]() )
				end
			end

			Datagram:GetCallBack()( data )
			
			return nil
			
		end
				
	};

};

net.Receive('ananke_nw',function( )

	Ananke.core.Network:Receive( )

end)