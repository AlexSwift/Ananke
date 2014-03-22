class "Ananke.core.Protocol" {

	private {
	
		Name = '';
		PID = 0x00;
		Type = '';
		CallBack = function() end;
		send = function() end;
		receive = function() end;
		Data = ''
		
	};

	public {
	
		static {
			
			_DATA = {};
			Loaded = false;
			
			Initialize = function( self )
			
				if self.Loaded then return end
	
				Ananke.core:IncludeDir( 'shared', Ananke.Name .. '/gamemode/core/shared/networking/protocols' )
				self.Loaded = true
			
			end;
			
			GetByID = function( self, PID )
				return self._DATA[PID]
			end
		
		};
	
		Register = function( self )
			self._DATA[self.PID] = self
		end;
		
		SetName = function( self , name )
			self.Name = name
		end;
		
		GetName = function( self )
			return self.Name
		end;
		
		SetSend = function( self , func )
			self.send = func
		end;
		
		GetSend = function( self )
			return self.send
		end;
		
		SetReceive = function( self, func )
			self.receive = func
		end;
		
		GetReceive = function( self )
			return self.receive
		end;
		
		SetCallBack = function( self , func )
			self.CallBack = func
		end;
		
		GetCallBack = function( self )
			return self.CallBack
		end;
		
		SetData = function( self , DT )
			self.Data = DT
		end;
		
		GetData = function( self )
			return self.Data
		end;
		
		SetType = function( self , DT )
			self.Type = DT
		end;
		
		GetType = function( self )
			return self.Type
		end;
		
		SetPID = function( self , PID )
			self.PID = PID
		end;
		
		GetPID = function( self )
			return self.PID
		end;
	};

}

