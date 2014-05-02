Ananke.core.EventManager:HookEvent( 'AnankeInitialize' , 'Ananke.core.Profiles_Flags_Class' , function( )

	Ananke.core.Flags:CreateClass( 'player' )
	
	Ananke.core.Flags:CreateFlag( 'player', 'b_isAdmin', 0 )
	Ananke.core.Flags:CreateFlag( 'player', 'b_isAlex', 1 )
	
end)


class 'Ananke.core.Profile_shared' {
	
	private {
	
		Data = {};	
		Player = null;
		Flags = Ananke.core.Flags.new( 'player' );
	
	};
	
	protected {
	
		SetValue = function( self, key, value )
				 
			if not self.DataTypes[ key ] then
				Ananke.core.Debug:Error( 'Invalid key to profile data table' )
				return nil
			end
			
			self.Data[ key ] = value
			
			if self.Network then
				self:Network( key )
			end
				
		end;
			
		GetValue = function( self, key )
			
			if not self.DataTypes[ key ] then
				Ananke.core.Debug:Error( 'Invalid key to profile data table' )
				return nil
			end
			
			if self.Data[ key ] then
				return self.Data[ key ]
			else
				return self.DataTypes[ key ].d_default
			end
			
		end;
		
		SetOwner = function( self, Player )
			
			if not player:IsPlayer() then
				Ananke.core.Debug:Error( 'Attempted to create profuile class for non player entity' )
				return nil
			end
			
			self.Player = Player
		end;
	
	};
	
	public {
	
	};
	
	static {
	
		protected {
		
			RegisterDataType = function( self , d_name, d_type, d_default )
			
				if self.DataTypes[ d_name ] then
					Ananke.core.Debug:Error( 'Attemted to overwrite preexisting data type ' .. d_name )
					return nil
				end
				
				if not self:IsValidDataType( d_type ) then
					Ananke.cire.Debug:Error( 'Invalide data type ' .. d_type )
					return nil
				end
				
				self.DataTypes[ d_name ] = { d_name = d_name, d_type = d_type, d_default = d_default or nil }
			
				return true
				
			end;
		
		};
		
		private {
		
			Profiles = {};
			DataTypes = {};
			
			IsValidDataType = function( self , d_type )
				
				local types = {
					'string',
					'number',
					'table',
					'Angle',
					'Colour'
				}
				
				for k,v in pairs( types ) do
					if v ~= d_type then
						continue
					else
						return true
					end
				end
				
				return false
			
			end;
		
		};
	
	};
	
};
	