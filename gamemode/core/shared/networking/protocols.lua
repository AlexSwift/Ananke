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
		end;
		
		GetSend = function( self )
			return self.send[1]
		end;
		
		SetReceive = function( self, func )
			self.receive = func
		end;
		
		GetReceive = function( self )
			return self.receive[1]
		end;
		
		SetCallBack = function( self , func )
			self.CallBack = func
		end;
		
		GetCallBack = function( self )
			return self.CallBack[1]
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
		end
	};
	public {
		Name = '';
		PID = 0x00;
		Type = '';
		CallBack = {};
		send = {};
		receive = {};
		Data = ''
	};
}

function protocols.Initialise()
	if protocol.Loaded then return end

	local f,d = file.Find( GM.Name .. "/gamemode/core/shared/networking/protocols/*.lua", "LUA" )

	print('\tLoading Protocols:')

	for k,v in pairs(f) do
		if SERVER then
			print('\t\tLoading ' .. v)
			do
				AddCSLuaFile( GM.Name .. '/gamemode/core/shared/networking/protocols/' .. v )
				include( GM.Name .. '/gamemode/core/shared/networking/protocols/' .. v )
			end
		else
			print('\t\tLoading ' .. v)
			do
				include( GM.Name .. '/gamemode/core/shared/networking/protocols/'.. v)
			end
		end
	end
	protocols.Loaded = true
end
