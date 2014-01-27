protocols = {}
protocols.Loaded = false

_PROTOCOLS = {}

class "protocol" {
	public {
		Register = function( self )
			_PROTOCOLS[self.PID] = self
		end;
		
		SetName = function( self , name )
			self.Name = name
		end;
		
		GetName = function( self )
			return self.Name
		end;
		
		SetSend = function( self , func )
			self.send = func
		end
		
		GetSend = function( self )
			return self.send
		end;
		
		SetReceive = function( self, func )
			self.receive = func
		end;
		
		GetReceive = function( self )
			return self.receive
		end
		
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
		
		SetPID = function( self , PID )
			self.PID = PID
		end;
		
		GetPID = function( self )
			return self.PID
		end
	};
	private {
		Name = '';
		PID = 0x00;
		Type = '';
		CallBack = function() end;
		send = function() end;
		receive = function() end;
		Data = ''
	};
}

function protocols.Initialise()
	if protocol.Loaded then return end

	local f,d = file.Find( "wp_base/gamemode/core/shared/networking/protocols/*.lua", "LUA" )

	print('\tLoading Protocols:')

	for k,v in pairs(f) do
		if SERVER then
			print('\t\tLoading ' .. v)
			do
				AddCSLuaFile('wp_base/gamemode/core/shared/protocols/'..v)
				include('wp_base/gamemode/core/shared/protocols/'..v)
			end
		else
			print('\t\tLoading ' .. v)
			do
				include('wp_base/gamemode/core/shared/protocols/'..v)
			end
		end
	end
	protocols.Loaded = true
end
