Ananke.core.menu = {}

Ananke.core.menu.Enabled = false
Ananke.core.menu.MousePos = { x = 0 , y = 0 }

Ananke.core.menu.ActiveElements = {}
Ananke.core.menu.Objects = {}

class "Ananke.core.menu.gui" {

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
		parent = nil; -- <class> core.menu.gui;
		x = 0;
		y = 0;
		SizeX = 0;
		SizeY = 0;
		Children = {}
		
	};
}

class 'Ananke.core.menu' {
	
	private {
	
		__constructor = function( self , name , parent )
			self.object = core.menu.gui[name].new()
			if parent then
				self:SetParent( parent )
			end

			obj:Init( )
			table.insert( core.menu.Elements , obj )
		end;

		object = nil; --Insert user data type here.
		
	};
	
	protected {
	
		Create = new;
		
		GetElements = function( )
			return Ananke.core.menu.Elements
		end;
		
		GetActiveElements = function()
			local enabled = {}
			for k,v in pairs(Ananke.core.menu.Elements) do
				if core.menu.Elements[k]:IsEnabled() then
					table.insert( enabled, Ananke.core.menu.Elements )
				end
			end
		end;
		
		Enable = function( )
			GAMEMODE:PreDrawMenu( )
			Ananke.core.menu.Enabled = true
		end;
		
		Disable = function( )
			GAMEMODE:PostDrawMenu()
			Ananke.core.menu.Enabled = false
		end;
		
	};
	
	public {
	
		static {
			
			Initialise = function()

				local f,d = file.Find( Ananke.Name .. "/gamemode/core/client/gui/*.lua", "LUA" )
			
				print('\tLoading Gui:')
				for k,v in pairs(f) do
					Ananke.include(Ananke.Name .. "/gamemode/core/client/gui/" .. v)
				end
			
			end;
		
		};
		
	};
			
}

class "Ananke.core.menu.renderStack" {
	
	private {
		layers = {}
	};
	
	public {
		__constructor = function(self)
			for i = 1, 5 do
				layers[i] = LinkedList.new()
			end
		end;
		
		Draw = function(self)
			-- loop through 'layers' calling Draw on each object
			for k,v in pairs(self['layers']) do
				for node in v:Iterate() do
					node:Draw()
				end
			end
		end;
		
		-- TODO: layer is enum value
		Add = function(self, obj, layer)
			self['layers'][layer]:AddHead(obj)
		end;
		
		-- TODO: layer is enum value
		Remove = function(self, obj, layer)
			self['layers'][layer]:RemoveByValue(obj)
		end;
	};
	
};

Ananke.core.menu.Initialise()


--				Usage:
-- local gui = core.menu.gui.Get( 'text' )
-- gui:AddParam( 'pos' , Vector( 50 , 50 , 0 ) )
-- gui:AddPapam( 'size' , Vector( 50 , 50 , 0 ) )
-- gui:AddParam( 'Text' , 'Main Menu' )
-- <Other params >


-- In the menu draw hook:
--  gui:Draw()

