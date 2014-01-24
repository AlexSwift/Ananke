core.menu = {}

core.menu.Enabled = false
core.menu.MousePos = Vector(0,0,0)

core.menu.Elements = {}

local _UI = {}
local _KEYS = {}

core.menu.gui = {}
core.menu.gui.__index = core.menu.gui

function core.menu.gui.New(base)

	local tabl = base and core.menu.gui.Create(base) or {}
	tabl['MouseInBounds'] = false

	return setmetatable(tabl,core.menu.gui)

end

function core.menu.gui.Create( name , parent )

	local obj = setmetatable( { } , _UI[name] )
	if parent then
		obj:SetParent( parent )
	end
	obj:Init( )

	table.insert( core.menu.Elements , obj )

	return obj

end

function core.menu.GetElements( )

	return core.menu.Elements

end

function core.menu.GetActiveElements( )

	local enabled = {}

	for k, v in pairs(core.menu.Elements) do
		if core.menu.Elements[k].IsEnabled() then
			table.insert( enabled, core.menu.Elements[k] )
		end
	end

	return enabled

end

----------------------Hooks-----------------------

function core.menu.gui:OnCursorMoved()

end

function core.menu.gui:OnCursorEntered()

end

function core.menu.gui:OnCursorExited()

end

function core.menu.gui:SetParent( parent )
	
	self['parent'] = parent
	
end

function core.menu.gui:GetParent( )
	
	local parent = self['parent'] or nil
	return parent
	
end

function core.menu.gui:SetPos( x , y )
	
	local parent = core.menu.gui:GetParent( )
	
	if parent then
		
		local px , py = parent:GetPos( )
		x = x + px
		y = y + py
		
	end
	
	self['x'] = x
	self['y'] = y
	
end

function core.menu.gui:GetPos( real ) --Real coordinates or relative ?
	
	local parent =  core.menu.gui:GetParent( )
	if real and parent then
		
		local px , py = parent:GetPos( true )
		local x = self['x']
		local y = self['y']
		
		return (px + x) , (py + y)
		
	else
		
		return self['x'] , self['y']
		
	end
end

function core.menu.gui:OnMenuKeyPress(keyCode)
	if _KEYS[keyCode] then
		_KEYS[keyCode]:Toggle()
	end
end

function core.menu.gui:Draw()
	for k, v in pairs(core.menu.Elements) do
		if v.IsEnabled() then
			v.Draw()
		end
	end
end

function core.menu.gui:Init()

end

---------------------------------------------------

function core.menu.gui:Register()

	_UI[self.name] = table.Copy(self)

end

function core.menu.gui:RegisterMenuKey( keyCode )

	_KEYS[keyCode] = self

end

function core.menu.gui:AddParam( ... ) --DEPRECATE

	local args = {...}

	if type(args[1]) == 'table' then
		for k,v in pairs(args[1]) do
			self[key] = value
		end
	else
		self[args[1]] = args[2]
	end

end

function core.menu.gui:GetParam( key , ... ) --Key, Default --DEPRECATE

	local args = {...}
	local ret = self[key] and self[key] or args[1]

	return ret

end

function core.menu.Initialise()

	local prefix = CLIENT and "lua_temp" or "gamemodes/wp_base/gamemode"

	local f,d = file.Find( prefix .. "/core/client/gui/*.lua", "GAME" )

	print('\tLoading Gui:')
	for k,v in pairs(f) do
		include('gui/'..v)
	end

	hook.Add( 'HUDPaint' , 'core.menu.draw' , function( )
		if !core.menu.Enabled then return end
		
		local elements = core.menu.GetActiveElements()
		
		local mp = Vector(0,0,0)
		mp.x,mp.y = gui.MousePos()
		if core.menu.MousePos != mp then
			for k,v in pairs(elements) do
				v:OnCursorMoved()
			end
		end

		core.menu.MousePos = mp

		for k,v in pairs(elements) do

			if vector.InBounds( v:GetParam( 'pos' ) , v:GetParam( 'pos' ) + v:GetParam( 'size' ) , core.menu.MousePos ) then
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
	
	hook.Add( 'OnKeyCodePressed', 'core.menu.keyPress', core.menu.gui.OnMenuKeyPress )

end

function core.menu.Enable( )

	GAMEMODE:PreDrawMenu( ) --USed to create elements

	core.menu.Enabled = true

end

function core.menu.Disable( )

	GAMEMODE:PostDrawMenu() --used to delete elements

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

