--[[
	Author:			Matthew Rabey and Alex Swift
	Name:			uiBase
	Description:	Base for all UIObjects in-game
]]--

class "core.menu.gui.uiBase" {

	meta {
		
	};

	protected {
		
		-- Initialise
		__construct = function(self, parent)
			if parent != nil then
				self:SetParent(parent)
			end
			
			self.relX = surface.ScreenWidth * 0.45
			self.relY = surface.ScreenHeight * 0.45
			
			self.width = surface.ScreenWidth * 0.1
			self.height = surface.ScreenWidth * 0.1
			
			self.scaleX = 1.0
			self.scaleY = 1.0
		end;
		
		__finalize = function(self)
		
		end;
		
		SetParent = function(self, parent)
			if self.parent then
				self.parent:RemoveChild(self)
			end
			
			self.parent = parent
			parent:AddChild(self)
		end;
		
		GetParent = function(self)
			return self.parent or nil
		end;
	
		SetPosition = function(self, x, y)
			local pX, pY = self.parent and self.parent:GetPosition() or 0.0, 0.0 -- if no parent, we default to screen coordinates
			
			local x , y = math.abs(x - pX), math.abs(y - pY)local _, pHeight = self.parent and self.parent:GetDimensions() or 0.0, surface.ScreenHeight
			
			self.relY = 1.0 - (offset + self.height) / pHeight
		end;
		
		AlignLeft = function(self, offset)
			local pWidth = self.parent and self.parent:GetDimensions() or surface.ScreenWidth
		
			self.relX = offset / pWidth
		end;
		
		AlignRight = function(self, offset)
			local pWidth = self.parent and self.parent:GetDimensions() or surface.ScreenWidth
		
			self.relX = 1.0 - (offset + self.width) / pWidth
		end;
		
		SetWidth = function(self, w)
			self.width = w
		end;
		
		SetHeight = function(self, h)
			self.height = h
		end;
		
		GetDimensions = function(self)
			return self.width, self.height
		end;
		
		AddChild = function(self, obj)
			if obj == nil then return end
			
			table.insert(self.children, obj)
		end;
		
		RemoveChild = function(self, obj)
			for k, v in pairs(self.children) do
				if v == obj then
					table.remove(self.children, obj)
				end
			end
		end;
		
		GetChildren = function(self)
			return self.children
		end;
		
		IsEnabled = function(self)
			return self.isEnabled
		end;
		
		ToggleEnabled = function(self)
			self.isEnabled = !self.isEnabled
			
			if #self.children > 0 then
				for k, v in pairs(self.children) do
					self.children[k]:ToggleEnabled()
				end
			end
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
	
	public {
	
		Draw = Draw;
	};
	
	private {
		parent = nil
		isEnabled = false
		children = {}
		
		relX = 0.0;
		relY = 0.0;
		width = 0.0;
		height = 0.0;
		scaleX = 0.0;
		scaleY = 0.0;
	};
}

local function Draw(self)
	--surface.DrawRect((surface.ScreenWidth * 0.5) - 50, (surface.ScreenHeight * 0.5) - 50, 100, 100)
end
