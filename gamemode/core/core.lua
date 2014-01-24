core = {}

core.FileSystem = {}
core.FileSystem.Data = {}

function core.Initialise()

	core.Loaded = {}

	local f,d = CLIENT and core.FileSystem.FindAll( "gamemodes/wp_base/gamemode/core/shared/" ) or file.Find( "gamemodes/wp_base/gamemode/core/shared/*.lua", "GAME" )

	core.Loaded['shared'] = {f,d}
	print('Loading Shared :')

	for k,v in pairs(f) do
		if SERVER then
			print('\tLoading ' .. v)
			do
				AddCSLuaFile("wp_base/gamemode/core/shared/" .. v)
				core.FileSystem.AddCSLuaFile( "wp_base/gamemode/core/shared/" .. v )
				include("wp_base/gamemode/core/shared/" .. v)
			end
		else
			print('\tLoading ' .. v)
			do
				include( "wp_base/gamemode/core/shared/" .. v)
			end
		end
	end


	f,d = CLIENT and core.FileSystem.FindAll( "gamemodes/wp_base/gamemode/core/client/" ) or file.Find( "gamemodes/wp_base/gamemode/core/client/*.lua", "GAME" )
	
	core.Loaded['client'] = {f,d}
	print('Loading client :') 
		for k,v in pairs(f) do
			do
				if SERVER then
					AddCSLuaFile("wp_base/gamemode/core/client/" .. v)
					core.FileSystem.AddCSLuaFile( "wp_base/gamemode/core/client/" .. v )
				else
					include("wp_base/gamemode/core/client/" .. v)
				end
			end
		end
	end

	if SERVER then

		f,d = file.Find( "gamemodes/wp_base/gamemode/core/server/*.lua", "GAME" )

		core.Loaded['server'] = {f,d}
		print('Loading Server :')
		for k,v in pairs(f) do
			if file.Size('gamemodes/wp_base/gamemode/core/server/'..v ,"GAME") == 0 then continue end
			print('\tLoading ' .. v)
			do
				include("wp_base/gamemode/core/server/" ..v)
			end
		end
	
		core.Filesystem.Send( ply )

	end

end

if SERVER then
	
	util.AddNetworkString( 'ananke.filesystem' )
	
	function core.FileSystem.AddCSLuaFile( file )
		
		table.insert( core.FileSystem.Data , file )
		
	end
	
	function core.Filesystem.Send( ply )
		
		net.Start( 'ananke.filesystem' )
		
			net.WriteUInt( #core.FileSystem.Data )
			
			for i = 1 , #core.FileSystem.Data do
				
				net.WriteString( core.FileSystem.Data[i]
					
			end
			
		net.Send( ply )
		
	end
	
	core.Initialise()
	
else
	
	function core.FileSystem.FindAll( path )
		
		local ret = { }
		
		for k,v in pairs( core.FileSystem.Data ) do
			
			if string.find( path , v ) then
				
				local file = string.TrimLeft( v , path )
				table.insert( ret , file )
				
			end
			
		end
		
		return ret, nil
		
	end

	net.Receive( 'ananke.filesystem', function( )
		
		local n = net.ReadUInt()
		
		for i = 1 , n do
			
			table.insert( core.FileSystem , net.ReadString )
			
		end
		
		core.Initialise()
		
	end)
	
end


-- Will have to rewrite for use on dedicated servers, and Client file system uses Lua_temp for file structure.
