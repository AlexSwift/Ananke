class "INIParser" {

	private {
	
		String = '';
		Data = { };
		CurrentBlock = '';
		Strict = false

	};
	
	protected {
	
		__tostring = function( self ) 
			return self:Output() 
		end;
		
		__construct = function( self , text )
			self.String = ''
			self.Data = { global = { } }
			self.CurrentBlock = 'global'
			self.Strict = false
			
			if text then
	
				self:Load( text )
				self:Parse( )
		
			end
		end;
		
		EscapeString = function( String )
			String = string.gsub( String , "\\\\" , "\\" )
			String = string.gsub( String , "\\0" , "\0" )
			String = string.gsub( String , "\\a" , "\a" )
			String = string.gsub( String , "\\b" , "\b" )
			String = string.gsub( String , "\\t" , "\t" )
			String = string.gsub( String , "\\r" , "\r" )
			String = string.gsub( String , "\\n" , "\n" )
			String = string.gsub( String , "\\;" , ";" )
			String = string.gsub( String , "\\#" , "#" )
			String = string.gsub( String , "\\=" , "=" )
			String = string.gsub( String , "\\:" , ":" )
			
			String = string.gsub( String , "\\x(%x+)" , function( x ) return string.char( tonumber(x, 16) ) end ) -- No unicode :(
			
			return String
		end;
		
		GetData = function( self, Block )
			if Block then return self.Data[ Block ] or false end
			return self.Data
		end;

		Load = function( self, String )
			self["String"] = String
			return self
		end;

		LoadFile = function( self, filename, path )
		
			if ( path == true ) then path = "GAME" end
			if ( path == nil || path == false ) then path = "DATA" end
			local f = file.Open( filename, "r", path )
			if ( !f ) then return end
			self:Load(f:ReadString( f:Size() ) )
			f:Close()
		
			return self
			
		end;

		SetCurrentBlock = function( self, Name )
		
			self.CurrentBlock = string.lower(Name)
			return self
		
		end;

		GetCurrentBlock = function( self )
			return self.Data[ string.lower(self.CurrentBlock) ]
		end;

		MakeBlock = function( self, Name, set )

			Name = INIParser.EscapeString( Name )
		
			if self.Strict then self.Data[ string.lower(Name) ] = { } end
			if not self.Data[ string.lower(Name) ] then self.Data[ string.lower(Name) ] = { } end
			if set then self.CurrentBlock = string.lower(Name) end
			
			return self
			
		end;

		AddValue = function( self, Key , Value )

			Key = INIParser.EscapeString( Key )
			Value = INIParser.EscapeString( Value )
		
			self:GetCurrentBlock( )[ string.lower(Key) ] = Value
			return self
		
		end;

		Parse = function( self )

			local String = self["String"]
			if not String then return end
		
			for k,v in pairs( string.Explode( "\n" , String ) ) do
			
				v = string.Trim( v )
				if ( #v < 2 ) then continue end
				
				if not ( string.sub( v , 1 , 1 ) == ";" or string.sub( v , 1 , 1 ) == "#" ) then
					
					for Name in string.gmatch( v , "%[([%w_]+)%]" ) do
						self:MakeBlock( Name, true )
					end
					
					for Key , Value in string.gmatch( v , "([%w_]+)%s*[=*:*]%s*([%w%s%p_]+)" ) do -- Added support for ":"
					
						if ( Key and Value ) then self:AddValue( Key , Value ) end
						
					end
		
				end
			
			end
			
			
			return self.Data
			
		end;

		Output = function( self )

			local String = ""
			
			for BlockName,v in pairs( self.Data ) do
			
				if ( table.Count(v) < 1 ) then continue end
			
				String = String .. "\n["..string.lower(BlockName).."]\n"
			
				for KeyName , Value in pairs( v ) do
				
					String = String .. KeyName .. " = " .. Value .. "\n"
				
				end
			
			end
			
			return String
		
		end;
		
	}
	
}


--- EXAMPLE -------

/*

INI = [[
# Made by James Swift's INIParser
# This is an automatic output

[owner]
name : John Doe
organization : Acme Widgets Inc.

[database]
port = 143
file = "HELLO.txt"
server = 192.0.2.62
]]

Table = INIParser.New( INI )

PrintTable( Table:GetData( ) )

]]--

*/