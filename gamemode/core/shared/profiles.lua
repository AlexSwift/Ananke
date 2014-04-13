class 'Ananke.core.profiles' {
	
	static {
	
		private {
		
			profiles = {}
			DataTypes = {}
			
		};
		
		protected {
		
			GetByID = function( self, ID )
				
				for k,v in pairs( self.profiles ) do
					if ID == v['ID'] then
						return v
					end
				end
			
			end;
			
			AddDataType = function( self, ... )
			
				local args = {...}
				DataTypes[ args['Name'] ] = args
				
			end
			
		};
	};
	
	private {
		
		Data = {}
		
	};
	
	protected {
		
		SetData = function( self, key, value )
		
			if not self.DataTypes[ key ] then 
				return nil
			end
			
			if SERVER then
				self.Data[ key ] = value
				self.DataTypes[ key ]:Network( value )
			elseif CLIENT then
				self.Data[ key ] = value 
			end
			
		end;
		
		GetData = function( self, key )
			
			if not self.DataTypes[ key ] then
				return nil
			end
			
			if not self.Data[ key ] then
				return self.DataTypes[ key ].Default
			end
			
			return self.Data[ key ]
		
		end;
		
		GetDataTypes = function( self )
			
			return self.DataTypes
			
		end;
		
	};
	
};
	
	