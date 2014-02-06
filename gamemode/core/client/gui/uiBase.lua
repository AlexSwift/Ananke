--[[
	Author:			Matthew Rabey and Alex Swift
	Name:			uiBase
	Description:	Base for all UIObjects in-game
]]--

PANEL = {}
PANEL.name = 'uiBase';

class "core.menu.gui.uiBase" {

	meta {
		
	};

	protected {
		
		SetParent = function(self, parent)
			if self.parent then
				self.parent:RemoveChild(self)
			end
			
			self.parent = parent
			parent:AddChild(self)
		end;
		
		GetParent = function(self)
			local ret = self.parent or nil -- Is this necessary?
			return ret
		end;
	
		SetPosition = function(self, x, y)
			local pX, pY = self.parent and self.parent:GetPosition() or 0.0, 0.0 -- if no parent, we default to screen coordinates
			
			x = math.abs(x - pX)
			y = math.abs(y - pY)
			
			self:AlignLeft(x)
			self:AlignTop(y)
		end;
		
		GetPosition = function(self)
			local pX, pY = self.parent and self.parent:GetPosition() or 0.0, 0.0
			local pW, pH = self.parent and self.parent:GetDimensions() or surface.ScreenWidth, surface.ScreenHeight
			
			return (self.relX * pW) + pX, (self.relY * pH) + pY
		end;
		
		AlignTop = function(self, offset)
			local _, pY = self.parent and self.parent:GetPosition() or 0.0, 0.0
			local _, pHeight = self.parent and self.parent:GetDimensions() or 0.0, surface.ScreenHeight
			
			self.relY = (pY + offset) / pHeight
		end;
		
		AlignBottom = function(self, offset)
			local _, pY = self.parent and self.parent:GetPosition() or 0.0, 0.0
			local _, pHeight = self.parent and self.parent:GetDimensions() or 0.0, surface.ScreenHeight
			
			self.relY = 1.0 - ((pY + offset) / pHeight)
		end;
		
		AlignLeft = function(self, offset)
			local pX = self.parent and self.parent:GetPosition() or 0.0
			local pWidth = self.parent and self.parent:GetDimensions() or surface.ScreenWidth
		
			self.relX = (pX + offset) / pWidth
		end;
		
		AlignRight = function(self, offset)
			local pX = self.parent and self.parent:GetPosition() or 0.0
			local pWidth = self.parent and self.parent:GetDimensions() or surface.ScreenWidth
		
			self.relX = 1.0 - ((pX + offset) / pWidth)
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
	
		-- Initialise
		__construct = function(self)
			relX = surface.ScreenWidth * 0.45
			relY = surface.ScreenHeight * 0.45
			
			width = surface.ScreenWidth * 0.1
			height = surface.ScreenWidth * 0.1
			
			scaleX = 1.0
			scaleY = 1.0
		end;
		
		__finalize = function(self)
		
		end;
	
		Draw = PANEL.Draw;
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

function PANEL.Draw(self)
	--surface.DrawRect((surface.ScreenWidth * 0.5) - 50, (surface.ScreenHeight * 0.5) - 50, 100, 100)
end

PANEL:Register();

