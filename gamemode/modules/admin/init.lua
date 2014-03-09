include('info.lua')
AddCSLuaFile( 'info.lua' )

Ananke.Admin = {}
Ananke.Admin._PLUGINS = {}

class 'Ananke.Admin.plugins' {
	
	private {
		
		_constructor = function( name )
			Name = name
		end;

	};
	
	protected {

		Get = function( name )
			if !Ananke.Admin._PLUGINS[ name ] then
				Ananke.debug.Error( 'ADMIN: Could not load plugin: ' .. name , false )
			else
				return Ananke.Admin._PLUGINS[ name ]
			end
		end;
	};
	
	public {
	
		Functions = {};
		Name = 'plugin_default';
		CallBack = function() end;
		args = {};
		
		Register = function( self )
			Ananke.Admin._PLUGINS[ self.Name ] = self
		end;
	}
}

function MODULE:Load()

	local f,d = file.Find( Ananke.Name .. "/gamemode/modules/admin/plugins/*.lua", "LUA" )
	
	print('\tLoading plugins:')
	
	for k,v in pairs(f) do
		if SERVER then
			print('\t\tLoading ' .. v)
			Ananke.AddCSLuaFile( Ananke.Name .. '/gamemode/modules/admin/plugins/'..v)
			Ananke.include( Ananke.Name .. '/gamemode/modules/admin/plugins/'..v)
		else
			print('\t\tLoading ' .. v)
			Ananke.include( Ananke.Name .. '/gamemode/modules/admin/plugins/'..v)
		end
	end
	
end
