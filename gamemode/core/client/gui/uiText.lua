
class "uiText" extends "uiBase" {
	
	private {
	
		Text = '';
		Font = '';
		Color = Color( 0 , 0 , 0 , 0);
		Size = 1
		
	};
	
	protected {
	
		SetText = function( self, str )
			self.Text = str or ''
		end;
		
		GetText = function( self )
			return self.Text or ''
		end;
		
		SetFont = function( self, font )
			self.Font = font or 'Default'
		end;
		
		GetFont = function( self )
			return self.Font or 'Default'
		end;
		
		SetSize = function( self, num )
			self.Size = num
		end;
		
		GetSize = function( self )
			return self.Size
		end;
		
		SetColor = function( self, c )
			self.Color = c
		end;
		
		GetColor = function( self )	
			return self.Color
		end;
		
		Draw = Draw;
	
	}
	
}

local Draw = function ()

	local x, y = self:GetPos( )
	local size = self:GetSize( )
	local color = self:GetColor() or Color( 255 , 255 , 255 , 255 )
	local font = self:GetFont()

	surface.SetTextPos( x , y )
	surface.SetTextColour( color )
	surface.SetFont( font )
	surface.DrawText( self:GetText() )

end

Ananke.core.Menu:Register(uiText, 'UIText')