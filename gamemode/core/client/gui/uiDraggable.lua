-- Abstract class that defines any UIObject that
-- can be 'dragged-n-dropped' on screen.

class "uiDraggable" {

	private {
	
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
	};

};