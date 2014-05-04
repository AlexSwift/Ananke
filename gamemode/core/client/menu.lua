class 'Ananke.core.Menu' {
	private {
	
		__constructor = function(self) -- To prevent instantiation of Ananke.core.Menu
		end;
		
		static {
			Enabled = false;
			
			Objects = {};
			
		};
		
	};
	
	protected {
	
	};
	
	public {
	
		static {
			RenderStack = {}; -- TEMP
			MousePos = { x = 0 , y = 0 };
		
			Initialize = function( self )
				self.RenderStack = RenderStack.new()
				
				self.RenderStack:Init()
			end;
			
			Register = function(self, obj, name)
				if type(obj) ~= "table" or type(name) ~= "string" then return end
				
				self.Objects[name] = obj
			end;
			
			Create = function(self, name, parent, layer)
				if !self.Objects[name] then return nil end
				
				local obj = self.Objects[name].new()
				
				if parent then
					layer = parent:GetLayer()
					obj:SetParent(parent)
				end
				
				obj:Init()
				obj:SetLayer(layer)
				self.RenderStack:Add( obj, layer )
				
				return obj
			end;
			
			Draw = function(self)
				self.RenderStack:Draw()
			end;
			
			GetActiveMenus = function(self)
				local menus = {}
				
				for k,v in self.RenderStack do
					table.insert(menus, v)
				end
				
				return menus
			end;
			
			Enable = function( )
				GAMEMODE:PreDrawHUD( )
				self.Enabled = true
			end;
			
			Disable = function( )
				GAMEMODE:PostDrawHUD()
				self.Enabled = false
			end;
		
			IsEnabled = function(self)
				return self.Enabled
			end;
			
			PrintObjects = function(self)
				print("OBJECTS SIZE: " .. #self.Objects)
				
				PrintTable(self.Objects)
				for k,v in pairs(self.Objects) do
					print("MENU: " .. k .. " as " .. v)
				end
			end;
		};
	};
};

class "RenderStack" {
	
	private {
		layers = {};
	
		numLayers = 4;
	};
	
	public {
		
		Init = function(self)
			for i = 1, self.numLayers do
				self.layers[i] = LinkedList.new()
			end
		end;
		
		Draw = function(self)
			surface.SetDrawColor(0, 0, 0, 255)
		
			for i = 1, self.numLayers do
				if self.layers[i]:IsEmpty() then continue end
				
				for node in self.layers[i]:Iterate() do
					if node.IsEnabled(node.value) then
						node.Draw(node.value)
					end
				end
			end
		end;
		
		Add = function(self, obj, layer)
			local val = Enums['UILAYERS'][layer]
			
			if val == nil then  return end
			print('RENDERSTACK.ADD layer = ' .. layer .. ' val = ' .. val)
			
			self['layers'][val]:AddHead(obj)
		end;
		
		Remove = function(self, obj, layer)
			local val = Enums['UILAYERS'][layer]
			
			if val == nil then return end
		
			self['layers'][val]:RemoveByValue(obj)
		end;
	};
	
};

