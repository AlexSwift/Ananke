-- Interface for ALL UIObjects.  If you want a class to
-- be considered a UIObject, then you must implement this interface.

class 'uiComponent' {
	public {
		abstract { -- All implementations of this interface MUST define these methods at minimum!
			Init = function(self)
			end;
		
			Draw = function(self)
			end;
			
			AddChild = function(self, obj, id)
			end;
			
			RemoveChild = function(self, obj)
			end;
			
			GetChild = function(self, obj)
			end;
		};
	};
};