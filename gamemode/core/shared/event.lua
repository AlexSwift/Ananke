class 'Ananke.core.EventManager' {
	
	static {

		private {
		
			Events = {};
		
		};
		
		public {
		
			RegisterEvent = function( self, m_name )
			
				if not self or not m_name then
					Ananke.core.Debug:Error( 'EventManager: invalid object Ananke.core.Debug or invalid Even name m_name' )
					return nil
				end
				
				if self.Events[ m_name ] then
					Ananke.core.Debug:Log( 'EventManager: Conflicting event names! ' .. m_name )
					Ananke.core.Debug:Error( 'EventManage: You have a conflicting even name, this will cause errors' )
					return nil
				end
				
				self.Events[ m_name ] = {}
			
			end;
			
			HookEvent = function( self, m_name, m_identifier, m_callback )
				
				if not m_name or not m_identifier or not m_callback then
					Ananke.core.Debug:Log( 'EventManager: Invalid arguments! ' )
					Ananke.core.Debug:Error( 'EventManager: Invalid arguments! code execution has stoped!' )
					return nil
				end
			
				if not self.Events[ m_name ] then
				
					-- Never mind, Event might not be registered, however this will not cause any errors, only broken code HEHEHE
					-- On second, though, I might as well just add it anyway, no harm done.
					
					self:RegisterEvent( m_name )
					
				end
				
				if self.Events[ m_name ][ m_identifier ] then
					-- However this will!
					Ananke.core.Debug:Log( 'EventManager: Overwriting pre-existing event callback! errors will incure' )
					Ananke.core.Debug:Error( 'EventManager: Pre-existing event has been overwritten, code execution has stoped' )
					return nil
				end
				
				-- Well ... Arguments are valid, nothing has been overwritten, Lenny isn't complaining about Lolicon, time to GO!
				
				self.Events[ m_name ][ m_identifier ] = m_callback
				
			end;
			
			ListEvents = function( self )
				
				local events = {}
				
				for k,v in pairs( self:GetEventsTable() ) do
					events[ #events > 1 and ( #events + 1 ) or 1 ] = k -- Messy, but all is does is increment the index
				end
				
				return events
				
			end;
			
			GetEventsTable = function( self ) --Static access to private member
				
				return self.Events
				
			end;
			
			ListEventCallbacks = function( self, m_name )
			
				local callbacks = {}
				
				for k,v in pairs( self:GetEventsTable()[m_name] and self:GetEventsTable()[m_name] or {} ) do
					callbacks[ #callbacks > 1 and ( #callbacks + 1 ) or 1 ] = v
				end
				
				return callbacks
				
			end;
				
			
			Call = function( self, m_name, ... )
				
				for k,v in pairs( self:ListEventCallbacks( m_name ) ) do
					v( ... )
				end
				
			end;
				
		
		};
	
	};
	
};