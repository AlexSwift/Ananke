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
		
	};
	
	private {
	
		resources = {};
		players = {};
	
	};
	
};