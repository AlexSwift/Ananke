class 'Ananke.core.Menu' {
	private {
	
		__constructor = function(self) -- To prevent instantiation of Ananke.core.Menu
		end;
		
		static {
			Enabled = false;
			
			Objects = {};
			RenderStack = {};
		};
		
	};
	
	protected {
	
	};
	
	public {
	
		static {
			MousePos = { x = 0 , y = 0 };
		
			Initialize = function( self )
				self.RenderStack = RenderStack.new()
				
				Ananke.core:IncludeDir( 'client' , Ananke.Name .. "/gamemode/core/client/gui")
			end;
			
			Register = function(self, obj, name)
				self.Objects[name] = obj
			end;
			
			Create = function(self, name, parent)
				if !self.Objects[name] then return nil end
				
				local obj = self.Objects[name].new()
				
				obj:Init()
				
				if parent then 
					obj:SetParent(parent)
				end
				
				return obj
			end;
			
			Draw = function(self)
				self.RenderStack:Draw()
			end;
			
			GetActiveMenus = function(self)
				local menus = {}
				
				for k,v in RenderStack do
					table.insert(menus, v)
				end
				
				return menus
			end;
			
			Enable = function( )
				GAMEMODE:PreDrawMenu( )
				self.Enabled = true
			end;
			
			Disable = function( )
				GAMEMODE:PostDrawMenu()
				self.Enabled = false
			end;
		
			IsEnabled = function(self)
				return self.Enabled
			end;
		};
	};
};

class "RenderStack" {
	
	private {
		layers = {}
	};
	
	public {
		__constructor = function(self)
			for i = 1, 4 do
				layers[i] = LinkedList.new()
			end
		end;
		
		Draw = function(self)
			for i = 1, 4 do
				for node in layers[i]:Iterate() do
					node:Draw()
				end
			end
		end;
		
		Add = function(self, obj, layer)
			if Enums['UILAYERS'][layer] == nil then return end
			
			self['layers'][layer]:AddHead(obj)
		end;
		
		Remove = function(self, obj, layer)
			if Enums['UILAYERS'][layer] == nil then return end
		
			self['layers'][layer]:RemoveByValue(obj)
		end;
	};
	
};

