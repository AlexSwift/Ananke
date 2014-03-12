class 'Ananke.core.profiles' {
	
	private {
	
		Owner = Entity( 0 );
		Data = {};
		ID = 000000001;
		
	};
	
	protected {
	
		SetOwner = function( self, ent )
			self.Owner = ent
		end;
		
		Set = function( self, key , value, Send, SendToAll )
		
			if !Ananke.core.profiles['types'][key] then return end
			self.Data[key] = value
			
			if not Send then return end
			
			self:Network( SendToAll and player.GetAll() or self.Owner )
		
		end;
		
		Network = function( self, rf )
		
			local rf = rf and rf or self.Owner
			
			for k,v in pairs(self['data']) do
				local nw = Ananke.Network.new()
				nw:SetProtocol(0x03)
				nw:SetDescription('Sending player variables')
				nw:SetRecipients(rf)
				nw:PushData(self.Owner:EntIndex())
				nw:PushData(key)
				nw:PushData(type(value))
				nw:PushData(value)
				nw:Send()
			end
			
		end;
		
		Get = function( self, key )
		
			if !Ananke.core.profiles['types'][key] then return end
			return self.Data[key] or nil
			
		end;
	
		Load = function( self, id , ... )
		
			local args = {...}
			local q = "SELECT * WHERE `id` = `" .. id .. "`;"
			
			core.MySQL.Query( q, function(data)
				local d = Ananke.core.serialization.decode(data[1])
				for k,v in pairs( d ) do
					self:Set( k, v, unpack(args) )
				end
			end)
			
			self.ID = id
			
		end;
		
		Save = function( self )

			local s_data = Ananke.core.serialization.encode( self.Data )

			local q = "UPDATE 'wp_profiles' SET `s_data`=`" .. s_data .. "` WHERE `id` =`" .. self.ID .."`;"
			Ananke.core.MySQL.Query( q )

		end;
	
		static {
			LoadPlayer = function (ply)
			
				local profile = Ananke.core.profiles.New()
				profile:Load(ply:SteamID())
				profile:SetOwner(ply)
				profile:Network()

			end;
		};
	};
};

