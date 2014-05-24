
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
				shared = {},
				client = {},
				server = {}
			};
			LoadDirectory = Ananke.Folder .. '/gamemode/'
		};
	
		public {
		
			SetDirectory = function( self, dir )
				self.LoadDirectory = dir
			end;
			
			GetDirectory = function( self )
				return self.LoadDirectory
			end;
		
			IncludeDir = function(self, state, dir, indentation, str, precall, postcall )
			
				local indentation = indentation or 0
				local str = str or ( state .. ' : ' .. dir )
				local precall = precall or function() end
				local postcall = postcall or function() end
				local dir = self:GetDirectory() .. '/' .. dir
			
				local f,d = file.Find( dir .. '/*.lua' , "LUA" )
				self.Loaded[state] = {f,d}
				
				print( string.Indentation( indentation ) ..'Loading ' ..  str ) 
				
				ProtectedCall( function() precall() end )
				
				if state == 'Client' then
				
					for k,v in pairs(f) do
						if SERVER then
							print( string.Indentation( indentation + 1 ) .. 'Sending ' .. v )
							ProtectedCall( function() Ananke.AddCSLuaFile( dir .. '/' .. v ) end )
						else
							print( string.Indentation( indentation + 1 ) .. 'Loading ' .. v )
							ProtectedCall( function() Ananke.include( dir .. '/' .. v ) end )
						end
					end
					
				elseif state == 'Shared' then
					for k,v in pairs(f) do
											
						print( string.Indentation( indentation + 1 ) .. 'Loading ' .. v )
					
						if SERVER then
							ProtectedCall( function() Ananke.AddCSLuaFile( dir .. '/' .. v ) end)
							ProtectedCall( function() Ananke.include( dir .. '/' .. v ) end )
						else
							ProtectedCall( function() Ananke.include( dir .. '/' .. v ) end )
						end
					end
				
				elseif state == 'Server' and SERVER then
					
					for k,v in pairs(f) do
						print( string.Indentation( indentation + 1 ) .. 'Loading ' .. v )
						ProtectedCall( function() Ananke.include( dir .. '/' .. v ) end )
					end
				
				end
				
				ProtectedCall( function() postcall() end )
			
			end;
			
			AddCSLuaDir = function( self, dir )
			
				if not SERVER then return end
			
				local f,d = file.Find( self:GetDirectory() .. '/' .. dir .. '/*' , "LUA" )
				
				print( 'Sending files ' .. dir )
				
				for k,v in pairs(f) do
					print( '\tSending : ' .. v )
					ProtectedCall( Ananke.AddCSLuaFile( self:GetDirectory() .. '/' .. dir .. '/' .. v ) )
				end
				
			end;
			
			SearchDirectory = function( self, dir )
			
				local f,d = file.Find( self:GetDirectory() .. '/' .. dir .. '/*' ,'LUA' )
				
				return f,d
				
			end;
			
		};
	};
};