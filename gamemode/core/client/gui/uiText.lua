PANEL = core.menu.gui.New('UIBase');
PANEL.name = 'UIText';

function PANEL:SetText( str )

	self.Text = str or ''

end

function PANEL:GetText( )

	return self.Text or ''

end

function PANEL:SetFont( font )

	self.Font = font or 'Default'

end

function PANEL:GetFont( )

	return self.Font or 'Default'

end

function PANEL:SetSize( num )
	
	self['size'] = num
	
end

function PANEL:GetSize( )
	
	return self['size']
	
end

function PANEL:SetColor( c )
	
	self['color'] = c
	
end

function PANEL:GetColor( )
	
	return self['color']
	
end

function PANEL:Draw()

	local x, y = self:GetPos( )
	local size = self:GetSize( )
	local color = self:GetColor or Colour( 255 , 255 , 255 , 255 )
	local font = self:GetFont()

	surface.SetTextPos( x , y )
	surface.SetTextColour( color )
	surface.SetFont( font )
	surface.DrawText( self:GetText() )

end

PANEL:Register();
