
class 'Ananke.core' {
	static {
		meta {
			__index = function(self, key)
				return self.core[key]
			end;
			
			__newindex = function(self, key, value)
				self.core[key] = value
			end;
		};
		
		private {
			core = {};
			Loaded = {
				['shared'] = {},
				['client'] = {},
				['server'] = {}
			};
		};
	
		public {
		
			IncludeDir = function(self, state, dir, indentation, str )
			
				local indentation = indentation or 0
			
				local f,d = file.Find( dir .. '/*.lua' , "LUA" )
				self.Loaded[state] = {f,d}
				
				print( string.Indentation( indentation ) ..'Loading ' .. ( str and str or ( state .. ' : ' .. dir ) ) ) 
				
				if state == 'client' then
				
					for k,v in pairs(f) do
						if SERVER then
							print('\tSending ' .. v)
							Ananke.AddCSLuaFile( dir .. '/' .. v )
						else
							print('\tLoading ' .. v)
							Ananke.include( dir .. '/' .. v )
						end
					end
					
				elseif state == 'shared' then
					for k,v in pairs(f) do
											
						print('\tLoading ' .. v)
					
						if SERVER then
							Ananke.AddCSLuaFile( dir .. '/' .. v ) 
							Ananke.include( dir .. '/' .. v ) 
						else
							Ananke.include( dir .. '/' .. v ) 
						end
					end
				
				elseif state == 'server' then
				
					if SERVER then
					
						for k,v in pairs(f) do
							print('\tLoading ' .. v)
							ProtectedCall( Ananke.include( dir .. '/' .. v ) )
						end

					end
				
				end
			
			end;
			
			AddCSLuaDir = function( self, dir )
			
				if not SERVER then return end
			
				local f,d = file.Find( dir .. '/*' , "LUA" )
				
				print( 'Sending files ' .. dir )
				
				for k,v in pairs(f) do
					print( '\tSending : ' .. v )
					ProtectedCall( Ananke.AddCSLuaFile( dir .. '/' .. v ) )
				end
				
			end;
		};
	};
};