
class 'Ananke.core.MySQL' {
	
	static {
	
		public {
		
			Initialize = function( self )
			
				if not tmysql then
					require( 'tmysql' )
				end
			
				local host = self.Host or '127.0.0.1'
				local user = self.Username or 'root'
				local pass = self.Password or ''
				local daba = self.Database or 'main'
				local port = self.Port or 3306 
				
				local Database, err = tmysql.initialize( host, user, pass, daba, port )
				
				if not Database then
				
					Ananke.core.Debug:Error( 'Unabled to connect to the Database!' )
					
				else
				
					Ananke.core.Debug:Log( '[Ananke] Connected to the Mysql Database')
					
					self.Loaded = true
					self.Database = Database
					
				end
				
			end;
			
			SetCredentials = function( self, host, user, pass, daba, port )
				
				self.Host = host or '127.0.0.1'
				self.Username = user or 'root'
				self.Password = pass or ''
				self.Database = daba or 'main'
				self.Port = port or 3306
				
			end;
			
			Query = function( self, q, callback, ...)

				local args = {...}
				local flags, vargs = (args[1] or nil),(args[2] or nil)
				
				table.insert( self.Queries, { q, callback, flags, vargs } )
				if self.InProg ~= true then
					self:Process()
				end
			end;
			
			Process = function( self )

				if not Ananke.core.MySQL.Loaded then
					--Do a retry timer
					return
				end

				local function callback( self, ... )
				
					self.Queries[1][2]( ... )
					self.Queries[1] = nil
					
					table.shift( self.Queries , 1)
					
					if self.Queries[1] ~= nil then
						self:Process()
					else
						self.InProg = false
					end
				end
				
				self.Database:Query( unpack( self.Queries[1] ) )
				self.InProg = true
				
			end;
			
			Insert = function( self, name , keys , values )
			
				local str = "INSERT INTO " .. name
				local str2 = " ( "
				
				for k,v in ipairs( keys ) do
					if k == 1 then str2 = str2 .. v 
					else str2 = str2 .. "," .. v end
				end
				
				str2 = str2 .. " ) VALUES( "

				for k,v in ipairs( values ) do
					if type( v ) == "number" then
						if k == 1 then str2 = str2 .. " " .. v .. ""
						else str2 = str2 .. ", " .. v .. "" end
					else
						if k == 1 then str2 = str2 .. " '" .. tmysql.escape(v) .. "'"
						else
							if ( !tmysql.escape(v) ) then print( "NIL VALUE IN " .. k .. " POSITION", name )
								PrintTable( keys )
								PrintTable( values )
							end
							str2 = str2 .. ", '" .. tmysql.escape(v) .. "'"
						end
					end
				end
				str = str .. str2 .. " )" 
				
				self:Query( str )
			end
		
		};
		
		protected {
		
			CollumnNames = function( self, DB ,tabl,callback)
				local q = "SELECT `COLUMN_NAME` FROM `INFORMATION_SCHEMA`.`COLUMNS` WHERE `TABLE_SCHEMA`='" .. DB .. "' AND `TABLE_NAME`='" .. tabl .. "';"
				self.Query( q, function(data)
					callback( data )
				end)
			end;
		
		};
		
		private {
		
			Host = '127.0.0.1';
			Username = 'root';
			Password = '';
			Database = 'main';
			Port = 3306;
			
			Loaded = false;
			InProg = false;
			
			Database = null;
			Queries = {};
		
		};
		
	};
	
};