Ananke.Admin = {}
Ananke.Admin._PLUGINS = {}

class 'Ananke.Admin.plugins' {
	
	protected {

		Get = function( name )
			if !Ananke.Admin._PLUGINS[ name ] then
				Ananke.debug.Error( 'ADMIN: Could not load plugin: ' .. name , false )
			else
				return Ananke.Admin._PLUGINS[ name ]
			end
		end;
		
		Register = function( self )
			Ananke.Admin._PLUGINS[ self.Name ] = self
		end;
		
		Load = function() end;
		Unload = function() end;
		
	};
	
	public {
	
		Name = 'plugin_name';
		Author = 'plugin_author';
		Contact = 'name@domaine.com';
		Website = 'www.website.com';
		Description = 'module_description';
	
		Functions = {};
		Data = {};
		args = {};
		
		static {
			Initialise = function( )
				local f,d = file.Find( Ananke.Name .. "/gamemode/modules/Admin/plugins/*.lua", "LUA" )
		
				print('\t\tLoading plugins:')
				
				for k,v in pairs(f) do
				
					PLUGIN = Ananke.Admin.plugins.new()
					
					if SERVER then
						print('\t\t\tLoading ' .. v)
						Ananke.AddCSLuaFile( Ananke.Name .. '/gamemode/modules/admin/plugins/'..v)
						Ananke.include( Ananke.Name .. '/gamemode/modules/admin/plugins/'..v)
					else
						print('\t\t\tLoading ' .. v)
						Ananke.include( Ananke.Name .. '/gamemode/modules/admin/plugins/'..v)
					end
					
					PLUGIN:Register()
					
					PLUGIN:Load()
				end
			end;
		};
	}
}

function MODULE:Load()

	Ananke.Admin.plugins.Initialise()
	
end
