core.menu = {}
core.menu.Enabled = false

core.menu.gui = {}
core.menu.gui.__index = {}

function core.menu.gui.New(base)
	local tabl = core.menu.gui.Get(base) or {}
	return setmetatable(tabl,table.Copy(core.menu.gui))
end

function core.menu.gui.Get( name )
	return setmetatable( { } , _UI[name] )
end


function core.menu.gui:Register()
	_UI[self.name] = table.Copy(self)
end

function core.menu.gui:AddParam( ... )
	local args = {...}
	if type(args[1]) == 'table' then
		for k,v in pairs(args[1]) do
			self[key] = value
		end
	else
		self[args[1]] = args[2]
	end
end

function core.menu.gui:GetParam( key , ... ) --Key, Default
	local args = {...}
	local ret = self[key] and self[key] or args[1]
	return ret
end

function core.menu.gui:DraW()
	--Override this function
end

function core.menu.Initialise()

	local prefix = CLIENT and "lua_temp" or "gamemodes/wp_base/gamemode"

	local f,d = file.Find( prefix .. "/core/client/gui/*.lua", "GAME" )

	print('\tLoading Gui:')

	for k,v in pairs(f) do
		print('\t\tLoading ' .. v)
		include('gui/'..v)

	end

	hook.Add( 'Draw' , 'core.menu.draw' , function( )
		if !core.menu.Enabled then return end
		GAMEMODE:DrawMenu( )
		return
	end

end

function core.menu.Enable( )
	core.menu.Enabled = true
end

function core.menu.Disable( )
	core.menu.Enabled = false
end


core.menu.Initialise()

--				Usage:
-- local gui = core.menu.gui.Get( 'text' )
-- gui:AddParam( 'x' , 50 )
-- gui:AddParam( 'y' , 50 )
-- gui:AddParam( 'Text' , 'Main Menu' )
-- <Other params >
-- gui:Draw()
-- gui = nil

