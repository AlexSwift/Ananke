class 'Ananke.Factions' {

	public {
	
		static {
			
			Initialise = function()
				
				--Load Player Classes here
				
			end
	
	};
	
	protected {
	
		SetupResources = function( self, data )
			
			for k,v in pairs( data ) do
				self.resources[ data.Name ] = data
			end
			
		end;
		
		AddResource = function( self, resource, amount )
			
			if not self.resources[ resource ] then
				Error( 'Invalid resource ' .. resource )
				return
			end
			
			self.resources[ resource ] = self.resources[ resource ] + amount
			self:Network( resource )
		
		end;
		
		SubtractResource = function( self, resource, amount )
			
			if not self.resources[ resource ] then
				Error( 'Invalid resource ' .. resource )
				return
			end
			
			if self.resources[ resource ] < amount then
				Error( 'Not enough resource ' .. resource )
				return
			end
			
			self.resources[ resource ] = self.resources[ resource ] - amount
			self:Network( resource )
			
		end;
	
		Network = function( self, resource ,ply )
			local nw = Ananke.core.protocol.new()
				nw:SetProtocol( 0x02 )
				nw:SetDescription( 'Automatic variable networking for Factions' )
				nw:PushData( resource )
				nw:PushData( type( self.resources[ resource ] ))
				nw:PushData( self.resources[ resource ] )
				nw:SetRecipients( ply )
			nw:Send()
		end;
		
		FullUpdate = function( self , ply )
		
			if not ply then
				ply = player.GetAll()
			else
				ply = { ply }
			end
			
			for k,v in pairs( self.resources ) do
				self:Network( k, ply )
			end
			
		end;
			
	};
	
	private {
	
		resources = {};
		players = {};
	
	};
}