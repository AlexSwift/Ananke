include('info.lua')
AddCSLuaFile( 'info.lua' )

Ananke.Admin = {}
Ananke.Admin._PLUGINS = {}

class 'Ananke.Admin.plugins' {
	
	private {
		
		Name = 'plugin_default';
		
	};
	
	protected {
		
		_constructor = function( name )
			Name = name
		end;
		
		Register = function( self )
			Admin._PLUGINS[ self.Name ] = self
		end;

		Get = function( name )
			if !Admin._PLUGINS[ name ] then
				Ananke.debug.Error( 'ADMIN: Could not load plugin: ' .. name , false )
			else
				return Admin._PLUGINS[ name ]
			end
		end;

		Initialise = function( )
			local f,d = file.Find( Ananke.Name .. "/gamemode/modules/admin/plugins/*.lua", "LUA" )

			print('\tLoading plugins:')
		
			for k,v in pairs(f) do
				if SERVER then
					print('\t\tLoading ' .. v)
					Ananke.AddCSLuaFile( GM.Name .. '/gamemode/modules/admin/plugins/'..v)
					Ananke.include( GM.Name .. '/gamemode/modules/admin/plugins/'..v)
				else
					print('\t\tLoading ' .. v)
					Ananke.include(GM.Name .. '/gamemode/modules/admin/plugins/'..v)
				end
			end
		end;
	}
}

hook.Add("Ananke.PostModuleLoad", "Ananke.PostModulesLoad.Admin", function()

	Ananke.Admin.plugins.Initialise() --Load all modules. We don't want to invoke a function that doesn't exist

end)
