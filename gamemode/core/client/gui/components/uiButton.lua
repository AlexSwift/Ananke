class "uiButton" extends "uiBase" {

	private {
	
		callback = function() end;
		
		idleImgID = 'NullObject';
		pressedImgID = 'NullObject';
		releasedImgID = 'NullObject';
		
		state = 'NullObject';
	};
	
	protected {
	};
	
	public {
		-- uiComponent Abstract Methods
		Init = function(self)
			self.idleImgID = surface.GetTextureID('warpac/button_Idle.vmt')
			self.pressedImgID = surface.GetTextureID('warpac/button_Press.vmt')
			self.releasedImgID = surface.GetTextureID('warpac/button_Release.vmt')
			
			self.state = 'Idle'
			
			self:SetLayer(1)
			self:SetSize(100, 50)
			self:SetScale(1.0, 1.0)
			self:AlignLeft(surface.ScreenWidth() * 0.55)
			self:AlignRight(surface.ScreenHeight() * 0.55)
		end;
		
		Draw = function(self)
			local x, y = self:GetPosition()
			
			surface.SetTexture(self.idleImgID)
			
			surface.DrawTexturedRect(x, y, self:GetWidth(), self:GetHeight())
		end;
		
		AddChild = function(self, obj, id)
		end;
		
		RemoveChild = function(self, obj)
		end;
		
		GetChild = function(self, obj)
		end;
		
		-- uiBase Abstract Methods
		OnCursorMoved = function(self)
		end;
		
		OnCursorEntered = function(self)
		end;
		
		OnCursorExited = function(self)
		end;
		
		OnMousePressed = function(self)
		end;
		
		OnMouseReleased = function(self)
			self.callback()
		end;
		
		OnMouseWheeled = function(self)
		end;
		
		-- uiButton Methods
		SetCallback = function(self, func)
			if type(func) != "function" then return end;
			
			self.callback = func
		end;
	};

};