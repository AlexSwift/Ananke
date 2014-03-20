class 'Ananke.Items' {
	
	private {
		
		Name = 'item_name';
		Description = 'item_description';
		Weight = 0;
		
		static {
		
			_ITEMS = {};
			
		};
		
		--Insert other private variables here.
		
	};
	
	public {
	
		static {
	
			Initialise = function() 
				
				Ananke.core:IncludeDir( 'shared' , Ananke.Name .. '/gamemode/modules/items/items/module/items' )
				
			end;
		
		};
	
	};
	
	protected {
	
		SetName = function( self, name )
			self.Name  = name
		end;
		
		GetName = function( self )
			return self.Name and self.Name or  'item_name'
		end;
		
		SetDescription = function( self, desc )
			self.Description = desc
		end;
		
		GetDescription = function( self )
			return self.Description and self.Description or 'item_description'
		end;
		
		static {
			
			Register = function( self )
				self._ITEMS[ self:GetName() ] = self
			end;
			
		};
	
	};
	
}

function MODULE:Load()
	Ananke.Items.Initialise()
end