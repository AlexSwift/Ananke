MODULE.Name = 'Chat Commands'
MODULE.Author = 'WARPAC Studios';
MODULE.Contact = 'n/a';
MODULE.Website = 'www.warpac-rp.com';
MODULE.Description = 'Chat command system.'

Ananke.ChatCommands = {}
Ananke.ChatCommands._CHATCOMMANDS = {}
Ananke.ChatCommands.Prefix = '>'

local function Validate(ply, data)
	if #data < self.data.minargs then
		ply:ChatPrint("Specified too few arguments for "..self.name..". Need "..self.data.minargs)
		return false
	end
	return true
end

class 'Ananke.ChatCommands' {
	
	private {
	
		Name = 'chatcommand.name';
		Author = 'module_author';
		Contact = 'name@domaine.com';
		Website = 'www.website.com';
		Description = 'module_description';
		
		Arguments = {};
		Callback = function() end;
		Precall = function() end;
		Postcall = function() end;
		
		Data = {};
	
	};
	
	protected {
	
		AddArgument = function( self, Type, required, default )
			
			if required == true then
				self.Data['MinimumArgs'] = self.Data['MinimumArgs'] and ( self.Data['MinimumArgs'] + 1 ) or 1
				table.insert( self.Arguments , { Type , default } )
			end
		
		end;
		
		SetCallback = function( self, func )		
			self.Callback = func			
		end;
		
		SetPrecall = function( self, func )			
			self.Precall = func
		end;
		
		SetPostcall = function( self, func )			
			self.Postcall = func
		end;
		
		Register = function( self )
			Ananke.ChatCommands._CHATCOMMANDS[self.Name] = self
		end;	
	
	};
	
	public {
		
		static {
			
			Get = function( Name )
				return Ananke.ChatCommands_CHATCOMMANDS[ Name ] or nil
			end;
			
			PlayerSay = function( ply, text, b_team )

				local Command = Ananke.ChatCommands.Get(string.TrimLeft( text:gsub( "^[".. Ananke.ChatCommands.Prefix .."/](%S+)(.*)", "%1" ) , Ananke.ChatCommands.Prefix ))
				local Arguments = {}
				local Data = {}
				
				if not Command then
					
					Ananke.core.debug.Log( 'Unknown Command ' .. Command )
					return 
				
				end
				
				text = text:gsub( "^[!/](%S+)%s*", "" )
				for v in text:gmatch( "(%S+)" ) do
					table.insert( Arguments , v )
				end
				
				for k,v in ipairs( Command.Arguments ) do
					Data[k] = args[k] or v[2]
				end
				
				local shouldpass = Command.Precall( ply, Data )
				if not shouldpass then
				
					Ananke.core.debug.Log( 'Command failed! ' .. Command )
					return 
					
				end
				
				Command.Callback(Data)
			
				Command.Postcall()
			
			end;
			
		};
		
	};

}

function MODULE.Hooks.PlayerSay( ply, text, b_team )

	Ananke.ChatCommands.PlayerSay( ply, text, b_team )
	
end)