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
				
				if parent then
					layer = parent:GetLayer()
				end
				
				local obj = self.Objects[name].new()
				
				if parent then 
					obj:SetParent(parent)
				end
				
				--obj:SetLayer( layer )
				obj:Init()
				
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
		layerEnum = {
			[1] = 'OVERLAY',
			[2] = 'FOREGROUND',
			[3] = 'MAIN',
			[4] = 'BACKGROUND'
		};
	};
	
	public {
		layers = {};
		
		Init = function(self)
			for i = 1, #self.layerEnum do
				self.layers[self.layerEnum[i]] = LinkedList.new()
			end
		end;
		
		Draw = function(self)
			print('RENDERSTACK.DRAW EXECUTING')
			for i = 1, 4 do
				if self.layers[self.layerEnum[i]]:IsEmpty() then continue end
				
				for node in self.layers[self.layerEnum[i]]:Iterate() do
					node:Draw()
				end
			end
		end;
		
		Add = function(self, obj, layer)
			if Enums['UILAYERS'][layer] == nil then  return end
			print('RENDERSTACK.ADD layer = ' .. layer)
			
			self['layers'][layer]:AddHead(obj)
		end;
		
		Remove = function(self, obj, layer)
			if Enums['UILAYERS'][layer] == nil then return end
		
			self['layers'][layer]:RemoveByValue(obj)
		end;
	};
	
};

