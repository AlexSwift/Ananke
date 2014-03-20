class "Ananke.core.Menu.gui.uiBase" {

	meta {
		
	};

	protected {
		SetParent = function(self, parent)
			if self['parent'] then
				self['parent']:RemoveChild(self)
			end
			
			self['parent'] = parent
			parent:AddChild(self)
		end;
		
		GetParent = function(self)
			local ret = self['parent'] or nil -- Is this necessary?
			return ret
		end;
	
		SetPosition = function(self, x, y)
			local pX, pY = self['parent'] and self['parent']:GetPosition() or 0.0, 0.0 -- if no parent, we default to screen coordinates
			
			x = math.abs(x - pX)
			y = math.abs(y - pY)
			
			self:AlignLeft(x)
			self:AlignTop(y)
		end;
		
		-- Always returns absolute screen coordinates
		GetPosition = function(self)
			local pX, pY = self['parent'] and self['parent']:GetPosition() or 0.0, 0.0
			local pW, pH = self['parent'] and self['parent']:GetSize() or surface.ScreenWidth, surface.ScreenHeight
			
			return (self['relX'] * pW) + pX, (self['relY'] * pH) + pY
		end;
		
		AlignTop = function(self, offset)
			local _, pH = self['parent'] and self['parent']:GetSize() or 0.0, surface.ScreenHeight
			
			self['relY'] = offset / pH
		end;
		
		AlignBottom = function(self, offset)
			local _, pH = self['parent'] and self['parent']:GetSize() or 0.0, surface.ScreenHeight
			
			self['relY'] = 1.0 - (offset + self['height']) / pH
		end;
		
		AlignLeft = function(self, offset)
			local pW = self['parent'] and self['parent']:GetSize() or surface.ScreenWidth
		
			self['relX'] = offset / pW
		end;
		
		AlignRight = function(self, offset)
			local pW = self['parent'] and self['parent']:GetSize() or surface.ScreenWidth
		
			self['relX'] = 1.0 - (offset + self['width']) / pW
		end;
		
		SetWidth = function(self, w)
			if w > 0 then
				self['width'] = w
			end
		end;
		
		SetHeight = function(self, h)
			if h > 0 then
				self['height'] = h
			end
		end;
		
		SetSize = function(self, w, h)
			self:SetWidth(w)
			self:SetHeight(h)
		end;
		
		GetSize = function(self)
			return self['width'] * self['scaleX'], self['height'] * self['scaleY']
		end;
		
		-- Sets the scale of itself and all children objects
		-- given the individual axis scales
		SetScale = function(self, x, y)
			self['scaleX'] = x
			self['scaleY'] = y
			
			if #self['children'] > 0 then
				for k, v in pairs(self['children']) do
					self['children'][k]:SetScale(x, y)
				end
			end
		end;
		
		GetScale = function(self)
			return self['scaleX'], self['scaleY']
		end;
		
		AddChild = function(self, obj)
			if obj == nil then return end
			
			table.insert(self['children'], obj)
		end;
		
		RemoveChild = function(self, obj)
			for k, v in pairs(self['children']) do
				if v == obj then
					table.remove(self['children'], obj)
				end
			end
		end;
		
		GetChildren = function(self)
			return self['children']
		end;
		
		IsEnabled = function(self)
			return self['isEnabled']
		end;
		
		ToggleEnabled = function(self)
			self['isEnabled'] = !self['isEnabled']
			
			if #self['children'] > 0 then
				for k, v in pairs(self['children']) do
					self['children'][k]:ToggleEnabled()
				end
			end
		end;
	};
	
	abstract {
		Draw = function(self)
		end;
	};
	
	public {
	-- Initialise
		__construct = function(self, parent)
			self:SetParent(parent)
		end;
		
		__finalize = function(self)
		
		end;
		
		Init = function(self)
		
		end;
		
		OnCursorMoved = function()
		end;
		
		OnCursorEntered = function()
		end;
		
		OnCursorExited = function()
		end;
		
		OnMousePressed = function()
		end;
		
		OnMouseReleased = function()
		end;
		
		OnMouseWheeled = function()
		end;
	};
	
	private {
		parent = nil
		children = {}
		isEnabled = false
		
		relX = 0.0;
		relY = 0.0;
		width = 1.0;
		height = 1.0;
		scaleX = 1.0;
		scaleY = 1.0;
	};
};