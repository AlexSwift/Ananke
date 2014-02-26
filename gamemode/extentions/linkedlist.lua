local Next = function(head, curr)
	if not curr then
		return head
	elseif type(curr['nextNode']) != "nil" then
		return curr['nextNode']
	else
		return nil
	end
end;

class "LLNode" {

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
			if type(obj) == "nil" then 
				Error("Cannot add a Nil Object\n")
				return nil
			end
			
			print("\nAddHead(" .. obj .. ")\n")
			local node = LLNode.new(obj, self['head'])
			
			if self:IsEmpty() then self['tail'] = node end
			self['head'] = node
			
			return self['head']
		end;
		
		-- Adds given 'obj' to the Tail of the list.
		-- Returns the tail of the list if succeeded, nil otherwise.
		AddTail = function(self, obj)
			if type(obj) == "nil" then
				Error("Cannot add a Nil Object")
				return nil
			elseif self:IsEmpty() then
				local node = self:AddHead(obj)
				return node
			end
			
			print("\nAddTail(" .. obj .. ")\n")
			local node = LLNode.new(obj, nil)
			self['tail'].nextNode = node
			self['tail'] = node
			
			return node
		end;
		
		-- Adds given 'obj' ahead of the given 'before' LLNode.
		-- Returns the LLNode added if succeeded.
		-- Returns nil if 'obj' is nil or 'before' isn't of type LLNode.
		AddBefore = function(self, obj, before)
			if type(obj) == "nil" then
				Error("\nCannot add a Nil Object\n")
				return nil
			elseif type(before['value']) == "nil" then
				Error("\nGiven 'before' is not of type: LLNode\n")
				return nil
			elseif before == self['head'] then
				local node = self:AddHead(obj)
				return node
			end
			
			print("\nAddBefore(" .. obj .. ", " .. before.value .. ")\n")
			
			local curr = self['head']
			while curr['nextNode'] != before do
				curr = curr['nextNode']
			end
			
			if type(curr) != "nil" then
				local node = LLNode.new(obj, before)
				
				curr['nextNode'] = node
				
				return node
			end
		end;
		
		-- Adds given 'obj' after the given 'after' LLNode.
		-- Returns the LLNode added if succeeded.
		-- Returns nil if 'obj' is nil or 'after' isn't of type LLNode.
		AddAfter = function(self, obj, after)
			if type(obj) == "nil" then
				Error("\nCannot add a Nil Object\n")
				return nil
			elseif type(after['value']) == "nil" then
				Error("\nGiven 'after' is not of type: LLNode\n")
				return nil
			elseif after == self['tail'] then
				local node = self:AddTail(obj)
				return node
			end
			
			print("\nAddAfter(" .. obj .. ", " .. after.value .. ")\n")
			
			local node = LLNode.new(obj, after['nextNode'])
			after['nextNode'] = node
		end;
		
		-- Removes the given LLNode 'node' from the LinkedList.
		Remove = function(self, node)
			if self:IsEmpty() then
				return
			elseif type(node) == "nil" or node['value'] == "nil" then
				Error("\nGiven 'node' is not of type: LLNode\n")
				return
			elseif node == self['head'] then
				self:RemoveHead()
				return
			elseif node == self['tail'] then
				self:RemoveTail()
				return
			end
			
			print("\nRemove(" .. node.value .. ")\n")
			
			local curr = self['head']
			while curr['nextNode'] != node do
				curr = curr['nextNode']
			end
			
			if type(curr) != "nil" then
				curr['nextNode'] = node['nextNode']
				
				node['nextNode'] = nil
				node['value'] = nil
			end
		end;
		
		-- Removes the first instance of a LLNode with value 'value' from the LinkedList.
		RemoveByValue = function(self, value)
			if self:IsEmpty() then
				return
			elseif type(value) == "nil" then
				Error("\nCannot remove a Nil Object.\n")
				return
			elseif self['head'].value == value then
				self:RemoveHead()
				return
			elseif self['tail'].value == value then
				self:RemoveTail()
				return
			end
			
			print("\nRemoveByValue(" .. value .. ")\n")
			
			local node = self['head']
			while node['nextNode'].value != value do
				node = node['nextNode']
			end
			
			if type(node) != "nil" then
				local delete = node['nextNode']
				node['nextNode'] = delete['nextNode']
				
				delete['nextNode'] = nil
				delete['value'] = nil
			end
		end;
		
		-- Removes the head of the LinkedList.
		RemoveHead = function(self)
			if self:IsEmpty() then return end
			
			print("\nRemoveHead()\n")
			
			local node = self['head']
			
			if self['head'] == self['tail'] then self['head'], self['tail'] = nil, nil end
			
			self['head'] = node.nextNode
			
			node['nextNode'] = nil
			node['value'] = nil
		end;
		
		-- Removes the tail of the LinkedList.
		RemoveTail = function(self)
			if not self:IsEmpty() then
				print("\nRemoveTail()\n")
			
				local newTail = self['head']
				while newTail['nextNode'] != self['tail'] do
					newTail = newTail['nextNode']
				end
				
				newTail['nextNode'] = nil
				local delete = self['tail']
				
				if self['head'] == self['tail'] then self['head'], self['tail'] = nil, nil end
				
				self['tail'] = newTail
				
				delete['nextNode'] = nil
				delete['value'] = nil
			end
		end;
		
		Clear = function(self)
			print("Clear():")
		
			while not self:IsEmpty() do
				self:RemoveHead()
			end
			
			self['head'], self['tail'] = nil, nil
		end;
		
		Find = function(self, obj)
			if type(obj) == "nil" then
				Error("Cannot find a Nil Object")
				return nil
			elseif self:IsEmpty() then
				return nil
			end
			
			print("Find(" .. obj .. ")\n")
		
			local node = self['head']
			
			while node != nil do
				if node['value'] == obj then break end
			
				node = node['nextNode']
			end
			
			return node
		end;
		
		-- Returns whether the LinkedList is empty.
		IsEmpty = function(self)
			return type(self['head']) == "nil"
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
		
		static {
			Test = function(self)
				print("********** TESTING LINKEDLIST **********")
				
				local lList = LinkedList.new()
				
				local head = lList:AddTail("first")
				local tail = head
				print("Head = " .. head.value .. "\nTail = " .. tail.value)
				
				tail = lList:AddTail("third")
				print("Head = " .. head.value .. "\nTail = " .. tail.value)
				
				local node = lList:AddAfter("second", head)
				print("Head = " .. head.value .. "\nTail = " .. tail.value)
				
				local invalid = {}
				node = lList:AddAfter("invalid", invalid)
				print("Head = " .. head.value .. "\nTail = " .. tail.value)
				
				tail = lList:AddAfter("fourth", tail)
				print("Head = " .. head.value .. "\nTail = " .. tail.value)
				
				local find = lList:Find("fifth")
				if find != nil then print("Found " .. find.value .. ".\n") end
				
				find = lList:Find("first")
				if find != nil then print("Found " .. find.value .. ".\n") end
				
				lList:Clear()
				head = lList:Head()
				tail = lList:Tail()
				
				lList:Clear()
				head = lList:Head()
				tail = lList:Tail()
				
				local index = 1
				print("\n\n- Printing contents -\n")
				for node in lList:Iterate() do
					print(index .. ") " .. node.value)
					index = index + 1
				end
				
				print("********** FINISHED LLIST TEST **********")
			end;
		};
	};
	
	private {
		head = {};
		tail = {};
	};

};