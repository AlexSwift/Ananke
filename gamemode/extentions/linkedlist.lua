local Next = function(head, curr)
	if not curr then
		return head
	elseif curr['nextNode'] != nil then
		return curr['nextNode']
	else
		return nil
	end
end;

class "LLNode" {

	meta {
		__index = function(self, key)
			if type(self['value']) == "table" then
				return self['value'][key]
			end
		end;
		
		__eq = function(self, key)
		
		end;
	};

	public {
		__construct = function(self, val, node)
			self['value'] = val;
			self['nextNode'] = node;
		end;
		
		__finalize = function(self)
		
		end;
		
		value = '';
		nextNode = {}
	};
};

class "LinkedList" {

	public {
		__construct = function(self)
			self['head'] = nil;
			self['tail'] = nil;
		end;
		
		__finalize = function(self)
			self:Clear()
		end;
		
		-- Adds given 'obj' to the Head of the list.
		-- Returns the head of the list if succeeded, nil otherwise.
		AddHead = function(self, obj)
			if obj == nil then 
				Error("LINKEDLIST: Cannot add a Nil Object\n")
				return nil
			elseif not self:ValidValue(obj) then
				Error("LINKEDLIST: Given 'obj' is not of type: " .. self['nodeType'] .. ".\n")
				return nil
			end
			
			local node = LLNode.new(obj, self['head'])
			
			if self:IsEmpty() then self['tail'] = node; self['nodeType'] = type(obj) end
			self['head'] = node
			
			return self['head']
		end;
		
		-- Adds given 'obj' to the Tail of the list.
		-- Returns the tail of the list if succeeded, nil otherwise.
		AddTail = function(self, obj)
			if obj == nil then
				Error("LINKEDLIST: Cannot add a Nil Object")
				return nil
			elseif self:IsEmpty() then
				local node = self:AddHead(obj)
				return node
			elseif not self:ValidValue(obj) then
				Error("LINKEDLIST: Given 'obj' is not of type: " .. self['nodeType'] .. ".\n")
			end
			
			local node = LLNode.new(obj, nil)
			self['tail'].nextNode = node
			self['tail'] = node
			
			return node
		end;
		
		-- Adds given 'obj' ahead of the given 'before' LLNode.
		-- Returns the LLNode added if succeeded.
		-- Returns nil if 'obj' is nil or 'before' isn't of type LLNode.
		AddBefore = function(self, obj, before)
			if obj == nil then
				Error("\nLINKEDLIST: Cannot add a Nil Object\n")
				return nil
			elseif not self:ValidValue(obj) then
				Error("\nLINKEDLIST: Given 'obj' is not of type: " .. self['nodeType'] .. ".\n")
				return nil
			elseif before['value'] == nil then
				Error("\nLINKEDLIST: Given 'before' is not of type: LLNode\n")
				return nil
			elseif before == self['head'] then
				local node = self:AddHead(obj)
				return node
			end
			
			local curr = self['head']
			while curr['nextNode'] != before do
				curr = curr['nextNode']
			end
			
			if curr != nil then
				local node = LLNode.new(obj, before)
				
				curr['nextNode'] = node
				
				return node
			end
		end;
		
		-- Adds given 'obj' after the given 'after' LLNode.
		-- Returns the LLNode added if succeeded.
		-- Returns nil if 'obj' is nil or 'after' isn't of type LLNode.
		AddAfter = function(self, obj, after)
			if obj == nil then
				Error("\nLINKEDLIST: Cannot add a Nil Object\n")
				return nil
			elseif not self:ValidValue(obj) then
				Error("\nLINKEDLIST: Given 'obj' is not of type: " .. self['nodeType'] .. ".\n")
				return nil
			elseif after['value'] == nil then
				Error("\nLINKEDLIST: Given 'after' is not of type: LLNode\n")
				return nil
			elseif after == self['tail'] then
				local node = self:AddTail(obj)
				return node
			end
			
			local node = LLNode.new(obj, after['nextNode'])
			after['nextNode'] = node
		end;
		
		-- Removes the given LLNode 'node' from the LinkedList.
		Remove = function(self, node)
			if self:IsEmpty() then
				return
			elseif node == nil or node['value'] == nil then
				Error("\nGiven 'node' is not of type: LLNode\n")
				return
			elseif node == self['head'] then
				self:RemoveHead()
				return
			elseif node == self['tail'] then
				self:RemoveTail()
				return
			end
			
			local curr = self['head']
			while curr['nextNode'] != node do
				curr = curr['nextNode']
			end
			
			if curr != nil then
				curr['nextNode'] = node['nextNode']
				
				node['nextNode'] = nil
				node['value'] = nil
			end
		end;
		
		-- Removes the first instance of a LLNode with value 'value' from the LinkedList.
		RemoveByValue = function(self, value)
			if self:IsEmpty() then
				return
			elseif value == nil then
				Error("\nCannot remove a Nil Object.\n")
				return
			elseif self['head'].value == value then
				self:RemoveHead()
				return
			elseif self['tail'].value == value then
				self:RemoveTail()
				return
			end
			
			local node = self['head']
			while node['nextNode'].value != value do
				node = node['nextNode']
			end
			
			if node != nil then
				local delete = node['nextNode']
				node['nextNode'] = delete['nextNode']
				
				delete['nextNode'] = nil
				delete['value'] = nil
			end
		end;
		
		-- Removes the head of the LinkedList.
		RemoveHead = function(self)
			if self:IsEmpty() then return end
			
			local node = self['head']
			
			if self['head'] == self['tail'] then 
				self['head'] = nil
				self['tail'] = nil
				self['nodeType'] = nil
			end
			
			self['head'] = node['nextNode']
			
			node['nextNode'] = nil
			node['value'] = nil
		end;
		
		-- Removes the tail of the LinkedList.
		RemoveTail = function(self)
			if self:IsEmpty() then return end
			
			local newTail = self['head']
			while newTail['nextNode'] != self['tail'] do
				newTail = newTail['nextNode']
			end
			
			newTail['nextNode'] = nil
			local delete = self['tail']
			
			if self['head'] == self['tail'] then
				self['head'] = nil
				self['tail'] = nil
				self['nodeType'] = nil
			end
			
			self['tail'] = newTail
			
			delete['nextNode'] = nil
			delete['value'] = nil
		end;
		
		Clear = function(self)
			print("Clear():")
		
			while not self:IsEmpty() do
				self:RemoveHead()
			end
			
			self['head'], self['tail'] = nil, nil
		end;
		
		Find = function(self, obj)
			if obj == nil then
				Error("Cannot find a Nil Object")
				return nil
			elseif self:IsEmpty() then
				return nil
			end
		
			local node = self['head']
			
			while node != nil do
				if node['value'] == obj then break end
			
				node = node['nextNode']
			end
			
			return node
		end;
		
		-- Returns whether the LinkedList is empty.
		IsEmpty = function(self)
			return self['head'] == nil
		end;
		
		-- Returns the head of the LinkedList.
		Head = function(self)
			return self['head']
		end;
		
		-- Returns the tail of the LinkedList.
		Tail = function(self)
			return self['tail']
		end;
		
		-- Function used in the generic for loop to iterate through
		-- the contents of the LinkedList.
		-- Ex: for node in lList:Iterate() do { ... } end
		Iterate = function(self)
			return Next, self['head'], nil
		end;

	};
	
	private {
		head = {};
		tail = {};
		
		nodeType = "";
		
		ValidValue = function(self, value)
			if self:IsEmpty() then return true end
			return type(value) == self['nodeType']
		end;
	};

};