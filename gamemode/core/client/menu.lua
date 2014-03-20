class 'Ananke.core.Menu' {
	
	private {
	
		__constructor = function( self , name , parent )
			self.object = core.menu.gui[name].new()
			if parent then
				self:SetParent( parent )
			end

			obj:Init( )
			table.insert( core.menu.Elements , obj )
		end;

		object = nil; --Insert user data type here.
		
		static {
		
			Enabled = false;
			MousePos = { x = 0 , y = 0 };
			ActiveElements = {};
			Objects = {};
			
		};
		
	};
	
	protected {
	
		Create = new;
		
		GetObjects = function( )
			return self.Objects 
		end;
		
		GetActiveElements = function()
			local enabled = {}
			for k,v in pairs(self.Objects) do
				if self.Objects[k]:IsEnabled() then
					table.insert( enabled, self.ActiveElements )
				end
			end
			
		end;
		
		Enable = function( )
			GAMEMODE:PreDrawMenu( )
			self.Enabled = true
		end;
		
		Disable = function( )
			GAMEMODE:PostDrawMenu()
			self.Enabled = false
		end;
		
	};
	
	public {
	
		static {
			
			Initialize = function( self )

				Ananke.core:IncludeDir( 'client' , Ananke.Name .. "/gamemode/core/client/gui/*.lua", "LUA" )
			
			end;
			
			renderStack = {}
		
		};
		
	};
			
}

class "Ananke.core.menu.renderStack" {
	
	private {
		layers = {}
	};
	
	public {
		__constructor = function(self)
			for i = 1, 5 do
				layers[i] = LinkedList.new()
			end
		end;
		
		Draw = function(self)
			-- loop through 'layers' calling Draw on each object
			for k,v in pairs(self['layers']) do
				for node in v:Iterate() do
					node:Draw()
				end
			end
		end;
		
		-- TODO: layer is enum value
		Add = function(self, obj, layer)
			self['layers'][layer]:AddHead(obj)
		end;
		
		-- TODO: layer is enum value
		Remove = function(self, obj, layer)
			self['layers'][layer]:RemoveByValue(obj)
		end;
	};
	
};

