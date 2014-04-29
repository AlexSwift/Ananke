
class 'Ananke.core.Profiles' extends 'Ananke.core.Profiles' {
	
	protected {

		/*
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
		*/
		
		--Needs improving
	
		/*
		Load = function( self, id , ... )
		
			local args = {...}
			local q = "SELECT * WHERE `id` = `" .. id .. "`;"
			
			Ananke.core.MySQL.Query( q, function(data)
				local d = Ananke.core.serialization.decode(data[1])
				for k,v in pairs( d ) do
					self:SetValue( k, v, unpack(args) )
				end
			end)
			
			self.ID = id
			
		end;
		*/
		
		--Needs redoing
		
		
		
		/*
		Save = function( self )

			local s_data = Ananke.core.serialization.encode( self.Data )

			local q = "UPDATE 'ananke_profiles' SET `s_data`=`" .. s_data .. "` WHERE `id` =`" .. self.ID .."`;"
			Ananke.core.MySQL.Query( q )

		end;
		*/
		
		--Needs redoing
	
		static {
			/*
			LoadPlayer = function (ply)
			
				local profile = Ananke.core.Profiles.New()
				profile:Load(ply:SteamID())
				profile:SetOwner(ply)
				profile:Network()
				
			end;
			*/
			
			--Needs redoing
			
		};
	};
};

