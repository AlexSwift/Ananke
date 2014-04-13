Ananke.Admin = {}
Ananke.Admin._PLUGINS = {}

class 'Ananke.Admin.plugins' {
	
	public {
	
		Name = 'plugin_name';
		Author = 'plugin_author';
		Contact = 'name@domaine.com';
		Website = 'www.website.com';
		Description = 'module_description';
	
		Functions = {};
		Data = {};
		args = {};
		
		Load = function() end;
		Unload = function() end;
		
		static {
			Initialise = function( )
				
				local precall = function()
					PLUGIN = Ananke.Admin.plugins.new()
				end
				
				local postcall = function()
					PLUGIN:Register()
					PLUGIN:Load()
					PLUGIN = nil
				end
				
				Ananke.core:IncludeDir( 'shared', Ananke.Name .. '/gamemode/modules/Admin/module/plugins', 2, 'Admin Modules:', precall, postcall )
				
			end;
			
			Register = function( self )
				Ananke.Admin._PLUGINS[ self.Name ] = self
			end;
			
			Get = function( name )
				if !Ananke.Admin._PLUGINS[ name ] then
					Ananke.debug.Error( 'ADMIN: Could not load plugin: ' .. name , false )
				else
					return Ananke.Admin._PLUGINS[ name ]
				end
			end;
			
		};
	}
}

function MODULE:Load()

	Ananke.Admin.plugins.Initialise()
	
end
