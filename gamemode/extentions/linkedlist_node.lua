class "LinkedList.Node" {

	public {
		__construct = function(self, value, nextNode)
			self['value'] = value
			self['nextNode'] = nextNode
		end;
		
		__finalize = function(self)
			self['value'] = nil;
			self['nextNode'] = nil;
		end;
		
		Next = function(self)
			return self['nextNode']
		end;
		
		SetNext = function(self, nextNode)
			if nextNode != nil then
				self['nextNode'] = nextNode
			end
		end;
	};
	
	private {
		value = nil;
		nextNode = nil;
	};

};