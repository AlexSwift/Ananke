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
			self['nextNode'] = nextNode
		end;
	};
	
	private {
		value = nil;
		nextNode = nil;
	};
};

class "LinkedList" {
	public {
		__construct = function(self)
		end;
		
		__finalize = function(self) -- Is this necessary?
			self:Clear()
		end;
	
		-- Adds given 'obj' to the head of the list.
		-- Returns the node if successful, nil otherwise.
		AddHead = function(self, obj)
			if(obj != nil) then
				local node = self['Node'].new(obj, self['head'])
				
				self['head'] = node
				
				self:IncreaseCount()
				
				return node
			end
			
			return nil
		end;
		
		-- Adds given 'obj' to the list before the given 'before' object.
		-- Returns the node added if successful, nil otherwise.
		AddBefore = function(self, obj, before)
			if(obj != nil) then
				if(before == self['head'] or self['head'] == nil) then
					self:AddHead(obj)
					return
				end
				
				local prev = nil
				local curr = self['head']
				
				while(curr != nil) do
					if(curr == before) then break end
					
					prev = curr
					curr = curr:Next()
				end
				
				if(curr != nil) then
					local node = self['Node'].new(obj, curr)
					prev:SetNext(node)
					self:IncreaseCount()
					
					return node
				end
			end
			
			return nil
		end;
		
		-- Adds given 'obj' to the list after the given 'after' object.
		-- Returns the node added if successful, nil otherwise.
		AddAfter = function(self, obj, after)
			if(obj != nil) then
				if(self['head'] == nil) then self:AddHead(obj); return; end
				
				local curr = self['head']
				
				while(curr != nil) do
					if(curr == after) then
						break
					end
					
					curr = curr:Next()
				end
				
				if(curr != nil) then
					local node = self['Node'].new(obj, curr:Next())
					curr:SetNext(obj)
					self:IncreaseCount()
					
					return node
				end
			end
			
			return nil
		end;
		
		-- Removes given 'obj' from the list, maintaining the link between all nodes.
		-- Returns the next node in the list if successful, nil otherwise.
		Remove = function(self, obj)
			if(obj != nil) then
				if(self['head'] == nil) then return end
				if(self['head'] == obj) then 
					self['head'] = obj:Next();  
					self:DecreaseCount(); 
					return head; 
				end
				
				local prev = nil
				local curr = self['head']
				
				while(curr != nil) do
					if(curr == obj) then break end
					
					prev = curr
					curr = curr:Next()
				end
				
				if(curr != nil) then
					local nextNode = curr:Next()
					prev:SetNext(nextNode)
					obj = nil
					self:DecreaseCount()
					
					return nextNode
				end
			end
			
			return nil
		end;
		
		Clear = function(self) -- Do we need to set each individual node and its parameters to null?
			self['head'] = nil
			
			self['count'] = 0
		end;
		
		
		-- Searches the list looking for 'obj'.
		-- Returns the index where 'obj' is located if successful.
		-- If the list is empty or 'obj' is nil, returns nil.
		-- If 'obj' is not in the list, returns -1.
		Find = function(self, obj)
			if(obj != nil) then
				local index = 1
				
				if(self['head'] == nil) then return nil end
				if(self['head'] == obj) then return index end
				
				local curr = self['head']
				
				while(curr != null) do
					if(curr == obj) then
						break
					end
					
					curr = curr:Next()
					index = index + 1
				end
				
				return curr and index or -1
			end
			
			return nil
		end;
		
		-- First attempts to locate the optional 'obj' given.
		-- If no 'obj' was found, defaults the start of the search to head.
		-- Returns the object located at the given index.
		Get = function(self, index, obj) -- Optional anchor point EX: Get(10, head) -> head + 10
			local anchor = Find(obj)
			
			if(anchor == nil) then 
				anchor = 0
			elseif(anchor == -1) then 
				Ananke.core.debug.Error("LinkedList does not contain specified object.", true)
			elseif(anchor + index > count) then 
				Ananke.core.debug.Error("Index out of range.", true) 
			end
			
			local curr = obj and obj or self['head']
			for i=anchor, anchor + index do
				if(curr == nil) then break end
				
				curr = curr:Next()
			end
			
			return curr
		end;
	};
	
	protected {
		IncreaseSize = function(self, num) -- Optional number to increase count by
			local inc = num and num or 1
			self['count'] = self['count'] + inc
		end;
		
		DecreaseSize = function(self, num) -- Optional number to decrease count by
			local def = num and num or 1
			self['count'] = self['count'] - def
		end;
	};
	
	private {
		head = nil;
		count = 0;
	};
};