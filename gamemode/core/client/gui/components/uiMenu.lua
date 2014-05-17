class "uiMenu" extends "uiBase, uiDraggable" {

	private {
	
		backgroundImgID = 'NullObject';
	
	};
	
	protected {
	};
	
	public {
		Init = function(self)
			self:SetLayer(1)
			self:SetSize(100, 50)
			self:SetScale(1.0, 1.0)
			self:AlignTop(surface.ScreenHeight() * 0.5)
			self:AlignLeft(surface.ScreenWidth() * 0.5)
			
			local closeBtn = Ananke.core.Menu:Create('UIButton', self, 'FOREGROUND')
			
			self.backgroundImgID = surface.GetTextureID('warpac/testBox.vmt')
		end;
		
		Draw = function(self)
			local x, y = self:GetPosition()
			
			surface.SetTexture(self.backgroundImgID)
			surface.DrawTexturedRect(x, y, self:GetWidth(), self:GetHeight())
			
			for k,v in pairs(self.children) do
				self.children[k]:Draw()
			end
		end;
		
		AddChild = function(self, obj, id)
			
		end;
		
		RemoveChild = function(self, id)
			
		end;
		
		GetChild = function(self, id)
			
		end;
		
		GetChildren = function(self)
			return self.children;
		end;
		
		OnCursorMoved = function(self)
			return
		end;
		
		OnCursorEntered = function(self)
			return
		end;
		
		OnCursorExited = function(self)
			return
		end;
		
		OnMousePressed = function(self)
			return
		end;
		
		OnMouseReleased = function(self)
			return
		end;
		
		OnMouseWheeled = function(self)
			return
		end;
		
		OnDrag = function(self)
		end;
		
		OnDragReleased = function(self)
		end;
	};

};

Ananke.core.Menu:Register(uiMenu, 'UIMenu');