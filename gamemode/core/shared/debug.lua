
class 'Ananke.core.debug' {

	static {
		
		public {
		
			Add = function( self )

				if not self.Enabled then return end
				
				local info = debug.getinfo(2, "nSl")
				local i = self.Stack[info.short_src][info.linedefined][1] + 1 or 1
				
				self.Stack[info.short_src] = self.Stack[info.short_src] or {}
				self.Stack[info.short_src][info.linedefined] = self.Data[info.short_src][info.linedefined] or {}
				self.Stack[info.short_src][info.linedefined] = { i , info , i / ( os.time() - self.TimeStamp ) }
				
			end;
			
			PrintData = function( self, ... )

				local args = {...}
				
				if args[1] and self.Stack[args[1]] then
					if args[2] and self.Stack[args[1]][args[2]] then
						return PrintTable( self.Stack[args[1]][args[2]] )
					else
						return PrintTable( self.Stack[args[1]] )
					end
				else
					return PrintTable( self.Stack )
				end
				
			end;
		
			SetActive = function( self, bActive )

				self.Enabled = bActive
				self.TimeStamp = self.Enabled and os.time() or 0
			
			end;
			
			Error = function( self, str , Halt )
			
				local func = Halt and Error or ErrorNoHalt
			
				local info = debug.getinfo(2, "nSl")
				table.insert( self.Errors , { str , info } )
				
				func( str )
				
			end;
			
			Print = function( self, str , type )

				if type == Enums['DEBUG'].DEBUG_PRINT then
					print( '[Ananke] ' .. str )
				elseif type == Enums['DEBUG'].DEBUG_ERROR then
					error( '[Ananke] ' .. str )
				elseif type == Enums['DEBUG'].DEBUG_ERRORNOHALT then
					ErrorNoHalt( '[Ananke] ' .. str )
				end
				
			end;
			
			Log = function( self, str, push, data )
	
				data = data or ''
				
				table.insert( self.Logs, { str , data } )
				
				if push then
					self:Print( str , push )
				end
				
			end;
		
		};
	
	};
	
	private {
	
		Errors = {};
		Logs = {};
		Stack = {};
		
		Enabled = false;
		TimeStamp = os.time()
	
	};

};

Enums['DEBUG'] = {

	DEBUG_PRINT = 1,
	DEBUG_ERROR = 2,
	DEBUG_ERRORNOHALT = 3

}
	

