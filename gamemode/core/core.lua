local Loaded = {
	['shared'] = {},
	['client'] = {},
	['server'] = {}
};

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
		};
	
		public {
			Initialise = function(self)
				local f,d = file.Find( Ananke.Name .. "/gamemode/core/shared/*.lua", "LUA" )

				Loaded['shared'] = {f,d}
				print('Loading Shared :')

				for k,v in pairs(f) do
					if SERVER then
						print('\tLoading ' .. v)
						Ananke.AddCSLuaFile( Ananke.Name .. "/gamemode/core/shared/" .. v )
						Ananke.include( Ananke.Name .. "/gamemode/core/shared/" .. v)
					else
						print('\tLoading ' .. v)
						Ananke.include( Ananke.Name .. "/gamemode/core/shared/" .. v)
					end
				end


				f,d = file.Find( Ananke.Name .. "/gamemode/core/client/*.lua", "LUA" )
				
				Loaded['client'] = {f,d}
				print('Loading client :') 
				for k,v in pairs(f) do
					do
						if SERVER then
							AddCSLuaFile( Ananke.Name .. "/gamemode/core/client/" .. v)
						else
							Ananke.include( Ananke.Name .. "/gamemode/core/client/" .. v)
						end
					end
				end
					
				if SERVER then

					f,d = file.Find( Ananke.Name .. "/gamemode/core/server/*.lua", "LUA" )

					Loaded['server'] = {f,d}
					print('Loading Server :')
					for k,v in pairs(f) do
						if file.Size( Ananke.Name .. '/gamemode/core/server/'..v , "LUA") == 0 then continue end
						print('\tLoading ' .. v)
						Ananke.include( Ananke.Name .. "/gamemode/core/server/" ..v)
					end

				end
				
				self['Loaded'] = Loaded
			end;
		};
	};
};

-- Will have to rewrite for use on dedicated servers, and Client file system uses Lua_temp for file structure.
