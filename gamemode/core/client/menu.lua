core.menu = {}
core.menu.Enabled = false
core.menu.MousePos = Vector(0,0,0)
core.menu.Elements = {}

_UI = {}

core.menu.gui = {}
core.menu.gui.__index = {}

function core.menu.gui.New(base)

	local tabl = core.menu.gui.Get(base) or {}
	tabl['MouseInBounds'] = false
	return setmetatable(tabl,core.menu.gui)

end

function core.menu.gui.Create( name )
	local obj = setmetatable( { } , _UI[name] )
	obj:Init
	table.insert( core.menu.Elements , obj )
	return setmetatable( { } , _UI[name] )

end

----------------------Hooks-----------------------

function core.menu.gui:OnCursorMoved()

end

function core.menu.gui:OnCursorEntered()

end

function core.menu.gui:OnCursorExited()

end

function core.menu.gui:Draw()

end

function core.menu.gui:Init()

end

---------------------------------------------------

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

		local mp = Vector(0,0,0)
		mp.x,mp.y = gui.MousePos()
		if core.menu.MousePos != mp then
			for k,v in pairs(core.menu.Elements) do
				v:OnCursorMoved()
			end
		end

		core.menu.MousePos = mp

		for k,v in pairs(core.menu.Elements) do

			if vector.InBounds( v:GetParam( 'pos' ) , v:GetParam( 'pos' ) + v:GetParam( 'size' ) , core.menu.MousePos )
				v:OnCursorEntered()
				v['MouseInBounds'] = true
			elseif v['MouseInBounds'] then
				v:OnCursorExited()
				v['MouseInBounds'] = false
			end

		end

		GAMEMODE:DrawMenu( )

		return
	end)

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
-- gui:AddParam( 'pos' , Vector( 50 , 50 , 0 ) )
-- gui:AddPapam( 'size' , Vector( 50 , 50 , 0 ) )
-- gui:AddParam( 'Text' , 'Main Menu' )
-- <Other params >


-- In the menu draw hook:
--  gui:Draw()

