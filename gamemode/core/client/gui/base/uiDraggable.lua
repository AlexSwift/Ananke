-- Abstract class that defines any UIObject that
-- can be 'dragged-n-dropped' on screen.

class "uiDraggable" {

	private {
		isDraggable = true;
	};
	
	protected {
	};
	
	public {
		abstract {
			OnDrag = function(self)
			end;
			
			OnDragReleased = function(self)
			end;
		};
		
		SetDraggable = function(self, state)
			isDraggable = state
		end;
	};

};