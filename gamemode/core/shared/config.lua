class 'Ananke.core.config' {	
	
	static {
	
		private {
		
			Config = {}
	
		};
	
		protected {
	
		};
		
		public {
		
			LoadConfigDirectory = function( self, dir )
				
				local files = Ananke.core:SearchDirectory( )
				
				for k,v in pairs( file ) do
				
					local path = dir .. '/' .. v
					-- INI parser here
					self:GetConfigCallback( path )()
					
				end
				
			end;
			
			AddConfigCallback = function( self, file, func )
				self.Config[ file ] = func
			end;
			
			GetConfigCallback = function( self, file )
			
				if not self.Config[ file ] then
					return nil
				end
				
				return self.Config[ file ]
			
			end;
				
		};
	}
	
};