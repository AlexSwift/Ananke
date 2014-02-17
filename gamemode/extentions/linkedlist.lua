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
		
		Value = function(self)
			return self['value']
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
				
				if(self['tail'] == nil) then self['tail'] = node end
				
				return node
			end
			
			return nil
		end;
		
		-- Adds given 'obj' to the tail of the list.
		-- Returns the node if successful, nil otherwise.
		AddTail = function(self, obj)
			if(obj != nil) then
				if(head == nil) then AddHead(obj); return end
				
				local node = self['Node'].new(obj, nil)
				
				self['tail']:SetNext(node)
				self['tail'] = node
				
				self:IncreaseSize()
				
				return node
			end
			
			return nil
		end;
		
		-- Adds given 'obj' to the list before the given 'before' node.
		-- Returns the node added if successful, nil otherwise.
		AddBefore = function(self, obj, before)
			if(obj != nil) then
				if(before['Next'] == nil) then return nil end
				if(before == self['head'] or self['head'] == nil) then
					local node = self:AddHead(obj)
					return node
				end
				
				local curr = self['head']
				while(curr:Next() != before) do
					curr = curr:Next()
				end
				
				if(curr != nil) then
					local node = self['Node'].new(obj, before)
					
					curr:SetNext(node)
					IncreaseSize()
					
					return node
				end
			end
			
			return nil
		end;
		
		-- Adds given 'obj' to the list after the given 'after' node.
		-- Returns the node added if successful, nil otherwise.
		AddAfter = function(self, obj, after)
			if(obj != nil) then
				if(after['Next'] == nil) then return nil end
				if(self['head'] == nil) then local node = self:AddHead(obj); return node end
				if(self['tail'] == after) then local node = self:AddTail(obj); return node end
				
				if(after != nil) then
					local node = self['Node'].new(obj, after:Next())
					
					after:SetNext(node)
					IncreaseSize()
					
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
					
					if(curr == self['tail']) then self['tail'] = prev end
					
					obj = nil
					self:DecreaseCount()
					
					return nextNode
				end
			end
			
			return nil
		end;
		
		Clear = function(self) -- Do we need to set each individual node and its parameters to null?
			self['head'] = nil
			self['tail'] = nil
			
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
			
			if(anchor == nil) then anchor = 0 end
			else if(anchor == -1) then Ananke.core.debug.Error("LinkedList does not contain specified object.", true) end
			else if(anchor + index > count) then Ananke.core.debug.Error("Index out of range.", true) end
			
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
		tail = nil;
		
		count = 0;
	};
};