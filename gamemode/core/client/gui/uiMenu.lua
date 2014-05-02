class "uiMenu" extends "uiBase, uiComponent, uiDraggable" {

	private {
		children = {};
	};
	
	protected {
	
	};
	
	public {
		Init = function(self)
			self:SetLayer(1)
			self:SetSize(100, 50)
			self:SetScale(1.0, 1.0)
			self:AlignTop(surface.ScreenWidth() * 0.5)
			self:AlignLeft(surface.ScreenHeight() * 0.5)
		end;
		
		Draw = function(self)
			print("DRAWING UIMENU OBJECT!")
			local x, y = self:GetPosition()
			local color = Color(0, 0, 0, 1)
			render.DrawQuadEasy(Vector(x, y, 0), Vector(0, 0, 1), self:GetWidth(), self:GetHeight(), color, 0)
		end;
		
		AddChild = function(self, obj, id)
			id = id or tostring(obj)
			
			self.children[id] = obj
		end;
		
		RemoveChild = function(self, id)
			if type(id) != "string" then id = tostring(id) end;
			
			self.children[id] = nil
		end;
		
		GetChild = function(self, id)
			if type(id) != "string" then id = tostring(id) end;
			
			return self.children[id]
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