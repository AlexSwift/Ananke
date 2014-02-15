class 'stack' {
	
	private {
		
		pointer = 0;
		data = ''
		
	};
	
	protected {
		
		SetPointer = function( self, point )
			self.pointer = point
		end;
		
		GetPointer = function( self )
			return self.pointer
		end;
		
		AdvancePointer = function( self , num)
			local p = self:GetPointer()
			p = p + num
			self:SetPointer( p )
		end;
		
		SetData = function( self, data )
			self.data = data
		end;
		
		GetData = function( self )
			return self.data
		end;
		
		Pop = function( self , num )
			local p_start = self:GetPointer()
			local p_end = p_start + num
			
			local ret = {}
			
			for i = 1, num do
				table.insert( string.byte( self.data , p_start + i ) )
			end
			
			return ret
		end;
		
		Push = function( self, data ) --Do we realy want to 'inject' data to the stack?
			local split_befor = string.split( self.data, 1 , self.pointer)
			local split_after = string.split( self.data , self.pointer + 1 , #self.data)
			
			self:SetData( split_befor .. data .. split_after )
		end;
	}
}