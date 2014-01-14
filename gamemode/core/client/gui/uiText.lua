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

function PANEL:Draw()

	local x, y = self:GetParam( 'pos' ).x, self:GetParam( ' pos').y
	local size = self:GetParam( 'size' ) or 12
	local colour = self:GetParam( 'colour' ) or Colour( 255 , 255 , 255 , 255 )
	local font = self:GetFont()

	surface.SetTextPos( x , y )
	surface.SetTextColour( colour )
	surface.SetFont( self:GetFont )
	surface.DrawText( self:GetText() )

end

PANEL:Register();
