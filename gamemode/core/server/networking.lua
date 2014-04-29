util.AddNetworkString('ananke_nw')

class 'Ananke.core.Network' extends 'Ananke.core.Network' {

	private {
	
		Recipients 	= null;
		
	};

	public {
		
		Send = function( self )
		
			net.Start('ananke_nw')
			
				net.WriteInt( self.PID, 0x20 )
				if self.protocol.send != null then
					self.protocol.send( self.Data )
				else
					for k,v in ipairs( self.Data ) do
						net[ 'Write' .. NW_TRANSLAITON[ type(v) ]() ](v)
					end
				end
		
				if self.Recipiants then
					net.Send( self.Recipiants )
					return
				end
		
			net.Send()
		
			return
		end;
				
	};

};

