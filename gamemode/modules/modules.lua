Ananke._MODULES = {}

class "Ananke.modules" {
	
	public {
		static {
			LoadModules = function( tab )
			
				print( 'Loading Modules' )
				for k,v in pairs( tab ) do
					print('\tLoaded module : ' .. v)
					
					MODULE = Ananke.modules.new() --Start MODULE 
					for f,func in pairs(Ananke.modules.functions) do
						func( Ananke.Name .. "/gamemode/modules/"..v)
					end
					MODULE:Register() --End Module
					
					hook.Call( "Ananke.PreModuleLoad", GAMEMODE, name )
					
					local call = Ananke.modules.Get( v ) and Ananke.modules.Get( v ):Load()
					
					hook.Call( "Ananke.PostModulesLoad", GAMEMODE, v )
					
				end	
			end;
			
			LoadModule = function( name )
			
				if !Ananke._MODULES[ name ] then return end
				print('\tLoaded module : ' .. name)
				
				MODULE = Ananke.modules.new() --Start MODULE 
				for f,func in pairs(Ananke.modules.functions) do
					func( Ananke.Name .. "/gamemode/modules/" .. name)
				end
				MODULE:Register() --End Module
				
				hook.Call( "Ananke.PreModuleLoad", GAMEMODE, name )
				
				Ananke.modules.Get( name ):OnLoad()
				
				hook.Call( "Ananke.PostModuleLoad", GAMEMODE, name )
				
			end;
			
			Initialise = function()
				for k,v in pairs(_MODULES) do
					modules.get( k ):OnLoad()
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


		
