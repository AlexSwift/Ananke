class 'Ananke.core.Network' extends 'Ananke.core.Network_shared' {

	public {

		Send = function( self )
		
			net.Start('ananke_nw')
				
				net.WriteInt( self.PID , 0x20 )
				if self.protocol:GetSend() != null then
					self.protocol.send( self.Data )
				else
					for k,v in ipairs(self.Data) do
						net[ 'Write' .. NW_TRANSLAITON[type(v)]() ](v)
					end
				end
			
			net.SendToServer()
			
		end;
				
	};
	
}
