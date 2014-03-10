Ananke._MODULES = {}

class "Ananke.Modules" {
	
	public {
		static {
			LoadModules = function( tab, dir)
				
				dir = dir or Ananke.Name .. "/gamemode/modules/"
				
				print( 'Loading Modules' )
				for k,v in pairs( tab ) do
					Ananke.Modules.LoadModule( v , dir )	
				end	
			end;
			
			LoadModule = function( name, dir )
			
				dir = dir or Ananke.Name .. "/gamemode/modules/"
				
				if Ananke._MODULES[ name ] then return end
				print('\tLoaded module : ' .. name)
				
				MODULE = Ananke.Modules.new()
				for f,func in pairs(Ananke.Modules.functions) do
					func( dir .. name)
				end
				MODULE:Register()
				local call = MODULE.Load and MODULE:Load()
				
			end;
			
			Initialise = function()
				for k,v in pairs(Ananke._MODULES) do
					local call = v.Load and v:Load()
				end
			end;
			
			Get = function( name )
				if Ananke._MODULES[ name ] then 
					return Ananke._MODULES[ name ]
				else
					Ananke.core.debug.Error( 'Module not found', false )
				end
			end;
			
		};
		
		Load = function() end;
		Unload = function() end;
	
	};
	
	protected {
	
		Name = 'module_name';
		Author = 'module_author';
		Contact = 'name@domaine.com';
		Website = 'www.website.com';
		Description = 'module_description';
		
		Hooks = {};
	
		Register = function( self )
			Ananke._MODULES[ self.Name ] = self
			
			for k,v in pairs( self:GetHooks() ) do 
			
				hook.Add( k , self.Name ..':' .. k , function( ... )
					local args = {...}
					v( unpack( args ) )
				end)
				
				print('\t\tRegistered Hook : ' .. k )
				
			end

		end;
		
		GetHooks = function( self )
			return self.Hooks 
		end
	};
	
	private {
		
		static {
			functions = {
			
				['init.lua'] = function(p)
					if !SERVER then return end
					Ananke.include(p .. "/init.lua")
				end,
						
				['cl_init.lua'] = function(p)
					if SERVER then
						Ananke.AddCSLuaFile(p .. '/cl_init.lua')
					else
						Ananke.include(p .. "/cl_init.lua")
					end
				end		
			};
			
		};
		
	};
}


		
