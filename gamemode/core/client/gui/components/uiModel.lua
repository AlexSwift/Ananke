local PANEL = {}

class "uiModel" extends "uiBase" {

	public {
		LayoutEntity = LayoutEntity;
	};
	
	protected {
	
		SetAnimSpeed = function( self, speed )
			self.m_fAnimSpeed = speed
		end;
		
		GetAnimSpeed = function( self )
			return self.m_fAnimSpeed
		end;
		
		SetCamPos = function( self, vec )
			self.vCamPos = vec
		end;
		
		GetCamPos = function( self )
			return self.vCamPos
		end;
		
		SetFOV = function( self , fov )
			self.fFOV = fov
		end;
		
		GetFOV = function( self )
			return self.fFOV
		end;
		
		SetLookAt = function( self , vec )
			self.vLookatPos = vec
		end;
		
		GetLookAt = function( self )
			return self.vLookatPos
		end;
		
		SetLookAng = function( self , ang )
			self.aLookAngle = ang
		end;
		
		GetLookAng = function( self )
			return self.aLookAngle
		end;
		
		SetAmbientLight = function( self , col )
			self.colAmbientLight = col
		end;
		
		GetAmbientLight = function( self )
			return self.colAmbientLight
		end;
		
		SetColor = function( self , col )
			self.colColor = col
		end;
		
		GetColor = function( self )
			return self.colColor
		end;
		
		SetAnimated = function( self , b )
			self.bAnimated = b
		end;
		
		GetAnimated = function( self )
			return self.bAnimated
		end;
		
	};
	
	
	private {
	
		m_fAnimSpeed 		= 1;
		Entity 				= Entity( 1 );
		vCamPos 			= Vector( 0 , 0 , 0 );
		fFOV				= 90;
		vLookatPos 			= Vector( 0 , 0 , 0 );
		aLookAngle 			= Angle( 0 , 0 , 0);
		colAmbientLight 	= Color( 0 , 0 , 0 );
		colColor 			= Color( 0 , 0 , 0 );
		bAnimated 			= false
	
	};
	
	public {
		
		Init 				= PANEL.Init;
		SetDirectionalLight = PANEL.SetDirectionalLight;
		SetModel 			= PANEL.SetModel;
		Draw 				= PANEL.Draw;
		RunAnimation 		= PANEL.RunAnimation;
		StartScene 			= PANEL.StartScene;
		LayoutEntity 		= PANEL.LayoutEntity
		
	}
}


function PANEL.Init( self )

	self.Entity = nil
	self.LastPaint = 0
	self.DirectionalLight = {}
	
	self:SetCamPos( Vector( 50, 50, 50 ) )
	self:SetLookAt( Vector( 0, 0, 40 ) )
	self:SetFOV( 70 )
	
	self:SetText( "" )
	self:SetAnimSpeed( 0.5 )
	self:SetAnimated( false )
	
	self:SetAmbientLight( Color( 50, 50, 50 ) )
	
	self:SetDirectionalLight( BOX_TOP, Color( 255, 255, 255 ) )
	self:SetDirectionalLight( BOX_FRONT, Color( 255, 255, 255 ) )
	
	self:SetColor( Color( 255, 255, 255, 255 ) )

end

function PANEL.SetDirectionalLight( self, iDirection, color )
	self.DirectionalLight[iDirection] = color
end

function PANEL.SetModel( self, strModelName )

	if ( IsValid( self.Entity ) ) then
		self.Entity:Remove()
		self.Entity = nil		
	end
	
	if ( !ClientsideModel ) then return end
	
	self.Entity = ClientsideModel( strModelName, RENDER_GROUP_OPAQUE_ENTITY )
	if ( !IsValid(self.Entity) ) then return end
	
	self.Entity:SetNoDraw( true )
	
	local iSeq = self.Entity:LookupSequence( "walk_all" );
	if (iSeq <= 0) then iSeq = self.Entity:LookupSequence( "WalkUnarmed_all" ) end
	if (iSeq <= 0) then iSeq = self.Entity:LookupSequence( "walk_all_moderate" ) end
	
	if (iSeq > 0) then self.Entity:ResetSequence( iSeq ) end
	
	
end

function PANEL.Draw( self )

	if ( !IsValid( self.Entity ) ) then return end
	
	local x, y = self:LocalToScreen( 0, 0 )
	
	self:LayoutEntity( self.Entity )
	
	local ang = self.aLookAngle
	if ( !ang ) then
		ang = (self.vLookatPos-self.vCamPos):Angle()
	end
	
	local w, h = self:GetSize()
	cam.Start3D( self.vCamPos, ang, self.fFOV, x, y, w, h, 5, 4096 )
	cam.IgnoreZ( true )
	
	render.SuppressEngineLighting( true )
	render.SetLightingOrigin( self.Entity:GetPos() )
	render.ResetModelLighting( self.colAmbientLight.r/255, self.colAmbientLight.g/255, self.colAmbientLight.b/255 )
	render.SetColorModulation( self.colColor.r/255, self.colColor.g/255, self.colColor.b/255 )
	render.SetBlend( self.colColor.a/255 )
	
	for i=0, 6 do
		local col = self.DirectionalLight[ i ]
		if ( col ) then
			render.SetModelLighting( i, col.r/255, col.g/255, col.b/255 )
		end
	end
		
	self.Entity:DrawModel()
	
	render.SuppressEngineLighting( false )
	cam.IgnoreZ( false )
	cam.End3D()
	
	self.LastPaint = RealTime()
	
end

function PANEL.RunAnimation( self )
	self.Entity:FrameAdvance( (RealTime()-self.LastPaint) * self.m_fAnimSpeed )	
end

function PANEL.StartScene( self, name )
	
	if ( IsValid( self.Scene ) ) then
		self.Scene:Remove()
	end
	
	self.Scene = ClientsideScene( name, self.Entity )
	
end

function PANEL.LayoutEntity( self, Entity )

	if ( self.bAnimated ) then
		self:RunAnimation()
	end
	
	Entity:SetAngles( Angle( 0, RealTime()*10,  0) )

end

Ananke.core.Menu:Register(uiModel, 'UIModel')