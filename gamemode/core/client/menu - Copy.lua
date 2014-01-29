core.menu = {}

core.menu.Enabled = false
core.menu.MousePos = { x = 0 , y = 0 }

core.menu.ActiveElements = {}
core.menu.Objects = {}

class "core.menu.gui" {

	public {
		OnCursorMoved = function()
		end;
		
		OnCursorEntered = function()
		end;
		
		OnCursorExited = function()
		end;
		
		AddChild = function( obj )
			table.insert( self.Children , obj )
		end;
		
		RemoveChild = function( obj )
			for k,v in pairs( self.Children ) do
				if v == obj then
					table.remove( self.Children , obj )
				end
			end
		end;
		
		SetParent = function( parent )
			if self['parent'] then
				self['parent']:RemoveChild( self )
			end
			self['parent'] = parent
			parent:AddChild( self )
		end;
		
		GetParent = function( )
			local parent = self['parent'] or nil
			return parent
		end;
		
		SetPos = function( x , y )
			local parent = core.menu.gui:GetParent( )
			if parent then
				
				local px , py = parent:GetPos( )
				x = x + px
				y = y + py
				
			end
			self['x'] = x
			self['y'] = y
	
		end;
		
		GetPos = function( real ) --Real coordinates or relative ?
			local parent = core.menu.gui:GetParent( )
			if real and parent then
				local px , py = parent:GetPos( true )
				local x = self['x']
				local y = self['y']
				
				return (px + x) , (py + y)
			else
				return self['x'] , self['y']
			end
		end;
		
		Draw = function()
			for k, v in pairs( self:GetChildren( ) ) do
				if v.IsEnabled( ) then
					v:Draw()
				end
			end

			self:Draw()
		end;
		
		Init = function()
		end;
		
		GetChildren = function()
			return self['Children']
		end;
		
		Register = function()
			local t = table.Copy(self)
			core.menu.Objects[t.name] = t
		end;
		
	};

	private {
		MouseInBounds = false;
		parent = nil -- <class> core.menu.gui;
		x = 0;
		y = 0;
		SizeX = 0;
		SizeY = 0;
		Children = {}
		
	};
}


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
		if core.menu.Elements[k]:IsEnabled() then
			table.insert( enabled, core.menu.Elements[k] )
		end
	end

	return enabled

end

function core.menu.Initialise()

	local f,d = file.Find( GM.Name .. "/gamemode/core/client/gui/*.lua", "LUA" )

	print('\tLoading Gui:')
	for k,v in pairs(f) do
		include('gui/'..v)
	end

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

hook.Add( 'HUDPaint' , 'core.menu.draw' , function( )
	if !core.menu.Enabled then return end
	
	local mp = { x = 0 , y = 0 }
	
	if gui.MousePos() != mp then
		for k,v in pairs(core.menu.ActiveElements) do
			v:OnCursorMoved()
		end
	end

	core.menu.MousePos = mp
	mp = nil; -- __gc

	for i = 1 , #elements do
		

	GAMEMODE:DrawMenu( )

	return
end)

--				Usage:
-- local gui = core.menu.gui.Get( 'text' )
-- gui:AddParam( 'pos' , Vector( 50 , 50 , 0 ) )
-- gui:AddPapam( 'size' , Vector( 50 , 50 , 0 ) )
-- gui:AddParam( 'Text' , 'Main Menu' )
-- <Other params >


-- In the menu draw hook:
--  gui:Draw()

