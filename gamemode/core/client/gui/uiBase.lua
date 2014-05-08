-- Abstract class that defines all basic data
-- members and related behaviour for UIObjects.

class "uiBase" {

	protected {
		SetPosition = function(self, x, y)
			local pX, pY = self['parent'] and self['parent']:GetPosition() or 0.0, 0.0 -- if no parent, we default to screen coordinates
			
			x = math.abs(x - pX)
			y = math.abs(y - pY)
			
			self:AlignLeft(x)
			self:AlignTop(y)
		end;
		
		AlignTop = function(self, offset)
			local pH = self['parent'] and self['parent']:GetHeight() or surface.ScreenHeight()
			
			self['relY'] = offset / pH
		end;
		
		AlignBottom = function(self, offset)
			local pH = self['parent'] and self['parent']:GetHeight() or surface.ScreenHeight()
			
			self['relY'] = 1.0 - (offset + self['height']) / pH
		end;
		
		AlignLeft = function(self, offset)
			local pW = self['parent'] and self['parent']:GetWidth() or surface.ScreenWidth()
		
			self['relX'] = offset / pW
		end;
		
		AlignRight = function(self, offset)
			local pW = self['parent'] and self['parent']:GetWidth() or surface.ScreenWidth()
		
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
	};
	
	public {
		abstract {
			Init = function(self)
			end;
		
			OnCursorMoved = function(self)
			end;
			
			OnCursorEntered = function(self)
			end;
			
			OnCursorExited = function(self)
			end;
			
			OnMousePressed = function(self)
			end;
			
			OnMouseReleased = function(self)
			end;
			
			OnMouseWheeled = function(self)
			end;
		};
		
		-- Always returns absolute screen coordinates
		GetPosition = function(self)
			local pX, pY = self['parent'] and self['parent']:GetPosition() or 0.0, 0.0
			local pW, pH = self['parent'] and self['parent']:GetSize() or surface.ScreenWidth(), surface.ScreenHeight()
			
			return (self['relX'] * pW) + pX, (self['relY'] * pH) + pY
		end;
		
		SetParent = function(self, parent)
			if self['parent'] then
				self['parent']:RemoveChild(self)
			end
			
			self['parent'] = parent
			parent:AddChild(self)
		end;
		
		SetLayer = function( self, layer )
			self.layer = layer
		end;
		
		GetParent = function(self)
			local ret = self['parent'] or nil -- Is this necessary?
			return ret
		end;
		
		GetLayer = function( self )
			--Check if layer is valid or it won't get drawn
			return self.layer
		end;
		
		GetScale = function(self)
			return self['scaleX'], self['scaleY']
		end;
		
		GetWidth = function(self)
			return self['width'] * self['scaleX']
		end;
		
		GetHeight = function(self)
			return self['height'] * self['scaleY']
		end;
		
		GetSize = function(self)
			return self['width'] * self['scaleX'], self['height'] * self['scaleY']
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
		
		TriggerEvent = function( self, name, ... )
			
			self:GetEventCallback( name )( self, ... )
			
		end;
		
		GetEventCallback = function( self, name )
			
			if not self.events[ name ] then
				Ananke.core.Debug:Error( 'Invalid trigger call' )
			end
			
			return self.events[ name ]
			
		end;
		
		ProccessTrigger = function( self, name, func )
		
			if self.events[ name ] then
				Ananke.core.Debug:Error( 'Invalid attempt to overwrite trigger' )
			end
			
			self.events[ name ] = func
			
		end;
		
	};
	
	private {
		layer = "NullVariable";
		parent = nil;
		children = {};
		events = {};
		isEnabled = false;
		
		relX = 0.0;
		relY = 0.0;
		width = 1.0;
		height = 1.0;
		scaleX = 1.0;
		scaleY = 1.0;
	};
};