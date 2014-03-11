Ananke.Items = {}
Ananke.Items._ITEMS = {}

class 'Ananke.Items' {
	
	private {
		
		Name = 'item_name';
		Description = 'item_description';
		Weight = 0;
		
		--Insert other private variables here.
		
	};
	
	public {
	
		static {
	
			Initialise = function() 
				
				print('Loading Items :')
			
				local f,d = file.Find( Ananke.Name '/gamemode/modules/items/items/module/items/*.lua', "LUA" )
				
				for k,v in pairs(f) do
				
					print('\tLoading ' .. v)
					
					Ananke.Include( Ananke.Name .. '/gamemode/modules/items/items/module/items/' ..v )
					if SERVER then
						Ananke.AddCSLuaFile( Ananke.Name .. '/gamemode/modules/items/module/items/' .. v )
					end
				end
				
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
				Ananke.Items._ITEMS[ self:GetName() ] = self
			end;
			
		};
	
	};
	
}

function MODULE:Load()
	Ananke.Items.Initialise()
end