Ananke._MODULES = {}

class "Ananke.modules" {
	
	abstract {
	
		Load = function() end;
		Unload = function() end;
		
	};
	
	public {
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
		}
	};
	
	protected {
	
		Register = function( self )
			Ananke._MODULES[ self.Name ] = self

		end;
		
		Get = function( name )
			if Ananke._MODULES[ name ] then 
				return Ananke._MODULES[ name ]
			else
				Ananke.debug.Error( 'Module not found', false )
			end
		end;
		
		LoadModules = function( tab )
		
			print( 'Loading Modules' )
			for k,v in pairs( tab ) do
				print('\tLoaded module : ' .. v)
				
				for f,func in pairs(Ananke.modules.functions) do
					func( GM.Name .. "/gamemode/modules/"..v)
				end
				
				hook.Call( "Ananke.PreModuleLoad", GAMEMODE, name )
				
				Ananke.modules.Get( v ):OnLoad()
				
				hook.Call( "Ananke.PostModulesLoad", GAMEMODE, v )
				
			end	
		end;
		
		LoadModule = function( name )
		
			if !Ananke._MODULES[ name ] then return end
			print('\tLoaded module : ' .. name)
			
			for f,func in pairs(Ananke.modules.functions) do
				func( Ananke.Name .. "/gamemode/modules/" .. name)
			end
			
			hook.Call( "Ananke.PreModuleLoad", GAMEMODE, name )
			
			Ananke.modules.Get( name ):OnLoad()
			
			hook.Call( "Ananke.PostModuleLoad", GAMEMODE, name )
			
		end;
		
		Initialise = function()
			for k,v in pairs(_MODULES) do
				modules.get( k ):OnLoad()
			end
		end
	};
	
	private {
		
		Name = 'module_name';
		
	};
}


		
