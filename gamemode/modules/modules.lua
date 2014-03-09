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
				
				MODULE = Ananke.Modules.new() --Start MODULE 
				for f,func in pairs(Ananke.Modules.functions) do
					func( dir .. name)
				end
				MODULE:Register() --End Module
				
				hook.Call( "Ananke.PreModuleLoad", GAMEMODE, name )
				
				local call = Ananke.Modules.Get( name ) and Ananke.Modules.Get( name ):Load()
				
				hook.Call( "Ananke.PostModuleLoad", GAMEMODE, name )
				
			end;
			
			Initialise = function()
				for k,v in pairs(_MODULES) do
					--Ananke.Modules.Get( k ):Load()
				end
			end;
			
			Get = function( name )
				
				if Ananke._MODULES[ name ] then 
					return Ananke._MODULES[ name ]
				else
					--Ananke.core.debug.Error( 'Module not found', false )
				end
			end;
			
		};
		
		Load = function() end;
		Unload = function() end;
	
	};
	
	protected {
	
		Register = function( self )
			Ananke._MODULES[ self.Name ] = self

		end;
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
		
		Name = 'module_name';
		Author = 'module_author';
		Contact = 'name@domaine.com';
		Website = 'www.website.com';
		Description = 'module_description'
		
	};
}


		
