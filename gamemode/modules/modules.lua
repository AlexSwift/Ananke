Ananke._MODULES = {}

class "Ananke.Modules" {
	
	public {
		static {
			LoadModules = function( tab, dir)
				
				print( 'Loading Modules' )
				
				dir = dir or Ananke.Name .. "/gamemode/modules/"
				
				for k,v in pairs( tab ) do
					Ananke.Modules.LoadModule( v , dir )	
				end	
				
			end;
			
			LoadModule = function( name, dir )
			
				print('\tLoading module : ' .. name)
				
				local dir = dir or Ananke.Name .. "/gamemode/modules/"
				
				if not file.Exists( dir .. name ..'/info.ini' , 'LUA' ) and SERVER then
					Error( '/t/tFailed to load module ' .. name .. ' as info file was not found!' )
					return
				end
				
				if Ananke._MODULES[ name ] then
					Error( '/t/tFailed to load module '.. name .. ' as module is already loaded ' )
					return 
				end
				
				MODULE = Ananke.Modules.new()
				
				MODULE.INI:LoadFile( dir .. name ..'/info.ini' , 'LUA' )
				MODULE.INI = MODULE.INI:Parse( )
				MODULE:SetInfo( MODULE.INI['Info'] )
				MODULE:SetFiles( { ['server'] = MODULE.INI['server'], ['client'] = MODULE.INI['client'] } )
				
				MODULE:LoadClient( dir, name )
				MODULE:LoadServer( dir, name )
				MODULE:LoadEntities( dir )
				MODULE:LoadWeapons( dir )
				MODULE:LoadEffects( dir )
				
				MODULE:Register()
				
				local call = MODULE.Load and MODULE:Load()
				
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
	
		Info = {};
		Files = {};
		Hooks = {};
		INI = INIParer.new( );
	
		Register = function( self )
			Ananke._MODULES[ self.Info.Name ] = self
			
			for k,v in pairs( self:GetHooks() ) do 
			
				hook.Add( k , self.Info.Name ..':' .. k , function( ... )
					local args = {...}
					v( unpack( args ) )
				end)
				
				print('\t\tRegistered Hook : ' .. k )
				
			end

		end;
		
		GetHooks = function( self )
			return self.Hooks 
		end;
		
		SetInfo = function( self, Info )
			self.Info = Info
		end;
		
		GetInfo = function( self )
			return self.Info and self.Info or false
		end;
		
		SetFiles = function( self, tab )
			self.Files = tab
		end
		
		GetFiles = function( self )
			return self.Files and self.Files
		end
		
	};
	
	private {
		
		LoadEffects = function( self, dir )
			for k,v in pairs( file.Find( dir .. self:GetInfo().Name .. '/effects/*' , 'LUA' , 'nameasc' ) ) do
				EFFECT = {}
				if CLIENT then
					Ananke.Include( dir .. self:GetInfo().Name .. '/effects/' .. v .. '/init.lua' )
				else
					Ananke.AddCSLuaFile( dir .. self:GetInfo().Name .. '/effects/' .. v .. '/init.lua' )
				end
				effects.Register( EFFECT, v )
				EFFECT = nil
			end
		end;
		
		LoadWeapons = function( self, dir )
			for k,v in pairs( file.Find( dir .. self:GetInfo().Name .. '/weapons/*' , 'LUA' , 'nameasc' ) ) do
				SWEP = {}
				if CLIENT then
					Ananke.Include( dir .. self:GetInfo().Name .. '/weapons/' .. v .. '/cl_init.lua' )
				else
					Ananke.Include( dir .. self:GetInfo().Name .. '/weapons/' .. v .. '/init.lua' )
					Ananke.AddCSLuaFile( dir .. self:GetInfo().Name .. '/weapons/' .. v .. '/cl_init.lua' )
				end
				weapons.Register( SWEP, v )
				SWEP = nil
			end
		end;
		
		LoadEntities = function( self, dir )
			for k,v in pairs( file.Find( dir .. name .. '/entities/*' , 'LUA' , 'nameasc' ) ) do
				ENT = {}
				if CLIENT then
					Ananke.Include( dir .. name .. '/entities/' .. v .. '/cl_init.lua' )
				else
					Ananke.Include( dir .. name .. '/entities/' .. v .. '/init.lua' )
					Ananke.AddCSLuaFile( dir .. name .. '/entities/' .. v .. '/cl_init.lua' )
				end
				scripted_ents.Register( ENT, v )
				ENT = nil
			end
		end;
		
		LoadClient = function( self, dir, name )
			for k,v in ipairs( MODULE:GetFiles()['client'] ) do				
				if CLIENT then
					Ananke.Include( dir .. name .. '/' .. v )
				else
					Ananke.AddCSLuaFile(  dir .. name .. '/' .. v )
				end
				
			end
		end;
		
		LoadServer = function( self, dir, name )
			if !SERVER then return end
			for k,v in ipairs( MODULE:GetFiles()['server'] and MODULE:GetFiles()['server'] ) do
				Ananke.Include( dir .. name .. '/' .. v )
			end
		end;
	}
}


		
