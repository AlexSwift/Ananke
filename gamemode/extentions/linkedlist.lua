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

class "LinkedList" {

	public {
		__construct = function(self)
		end;
		
		__finalize = function(self) -- Is this necessary?
			self:Clear()
		end;
	
		AddHead = function(self, obj)
			if(obj != nil) then
				local node = self['Node'].new(obj, self['head'])
				
				self['head'] = node
				
				self:IncreaseCount()
				
				return node
			end
		end;
		
		AddBefore = function(self, obj, before)
			if(obj != nil) then
				if(before == self['head'] or self['head'] == nil) then
					return self:AddHead(obj)
				end
				
				local prev = nil
				local curr = self['head']
				
				while(curr != nil) do
					if(curr == before) then
						break
					end
					
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
		end;
		
		AddAfter = function(self, obj, after)
			if(obj != nil) then
				if(self['head'] == nil) then return self:AddHead(obj) end
				
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
		end;
		
		Remove = function(self, obj)
			if(obj != nil) then
				if(self['head'] == nil) then return end
				if(self['head'] == obj) then self['head'] = obj:Next(); return end
				
				local prev = nil
				local curr = self['head']
				
				while(curr != nil) do
					if(curr == obj) then
						break
					end
					
					prev = curr
					curr = curr:Next()
				end
				
				if(curr != nil) then
					prev:SetNext(curr:Next())
					obj = nil
					self:DecreaseCount()
				end
			end
		end;
		
		Clear = function(self) -- Do we need to set each individual node and it's parameters to null?
			self['head'] = nil
			
			self['count'] = 0
		end;
		
		
		-- Returns the index indicating the the first instance of 'obj'.
		-- If 'obj' not found, returns -1.
		-- If 'obj' is nil, returns nil
		Find = function(self, obj)
			if(obj != nil) then
				local index = 1
				
				if(head == nil) then return nil end
				if(head == obj) then return index end
				
				local curr = head
				
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
		
		Get = function(self, index, obj) -- Optional anchor point EX: Get(10, head) -> head + 10
			local anchor = Find(obj)
			
			if(anchor == nil) then anchor = 0 end
			if(anchor == -1) then Error("LinkedList does not contain specified object.") end
			if(anchor + index > count) then Error("Index out of range.") end
			
			local curr = head
			for i=0, anchor + index do
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
			self['count'] = self['count'] - dec
		end;
	};
	
	private {
		head = nil;
		count = 0;
	};

};