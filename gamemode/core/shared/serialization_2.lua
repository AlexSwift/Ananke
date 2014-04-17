
class 'Ananke.core.serialization'{

	static {
	
		private {
		
			Translation = {}
		
		};
		
		public {
		
			Initialize = function( self )
				--http://puu.sh/7LP2Q
			end;
		
			AddTranslation = function( self, tabl )
			
				if self.Translation[ typ ] then 
					Ananke.core.debug:Log( 'Type ' .. typ .. ' already exists in translation db!! Expect serialization errors' )
					Error( 'Type ' .. typ .. ' already exists in translation db!! Expect serialization errors' )
				end
			
				self.Translation[ tabl['type'] ] = {ID = tabl['ID'], 
													Encode = tabl['Encode'],
													Decode = tabl['Decode'], 
													Size = tabl['Size'] } --This seems pretty pointless, but it's more to to with idiotproofing the code.
			
			end;
			
			GetTranslation = function( self, typ )
			
				if type( typ ) == 'number' then
					return self.Translation[ typ ]
				elseif type( typ ) == 'string' then
					local k = self:GetTypeFromByte( typ )
					return self.Translation[ k ]
				else
					return { nil, nil, nil, nil } --NIL THE FUCK OUT OF SHITTY CODER
				end
			
			end;
			
			GetTranslationTable = function( self )
				
				return self.Tranlsation
				
			end;
			
			GetTypeFromByte = function( self, byte )
				for typ,translation in pairs( self:GetTranslationTable() ) do
					if translation[1] == byte then
						return k
					end
				end
			end;
			
			Encode  = function( self, data )
				local typ = type( data )
				local s_data = ''
				s_data = s_data .. string.char( self:GetTranslation( typ )['ID'] ) --types
				s_data = s_data .. self:GetTranslation( typ )['Size']( self, data ) -- size of Bytes to write 
				s_data = s_data .. self:GetTranslation( typ )['Encode'](  self, s_data) --Data -> s_data

				return s_data
			end;
			
			Decode = function( self, s_data )
			
				local data = ''
				local data_raw = ''
				
				local translation = self:GetTranslation( s_data[1] )
				local size = s_data[2]
				
				for i = 3, size do
					data_raw = data_raw .. s_data[i]
				end
				
				data = translation:Decode( data_raw )
				
				return data
			end
		
		};
	
	};
	
};

Ananke.core.serialization:AddTranslation( 
{	['ID']		= 1,
	['type']	= 'string',
	['Encode']	= function( self, data )
		return data
	end,
	['Decode']	= function( self, s_data )
		return s_data
	end,
	['Size']	= function( self, data )
		return string.len( data )
	end})
	
Ananke.core.serialization:AddTranslation( 
{	['ID'] 		= 2,
	['type'] 	= 'table',
	['Encode'] 	= function( self, data )
		local s_data = ''
		for k,v in ipairs( data ) do
	
			s_data = s_data .. self:Encode(k)
			s_data = s_data .. self:Encode(v)
	
		end
		return s_data
	end,
	['Decode'] 	= function( self, s_data )

		local data = {}

		local tabl = string.explode( '' , s_data ) --Expensive, I will implement a stack for this
		for i = 1 , #tabl do
			local typ = string.GetChar( i )
			local bytes = string.byte(string.GetChar( i + 1 ))

			local key = self:GetTranslation( typ )['Decode']( string.sub( s_data, i + 3, i + 2 + bytes ) )

			typ = string.GetChar( i + 3 + bytes )
			local bytes2 = string.byte(string.GetChar( i + 4 + bytes))

			local value =  self:GetTranslation( typ )['Decode'](string.sub( s_data, i + 4 + bytes, i + 3 + bytes + bytes2))

			data[key] = value
			i = i + 4 + bytes + bytes2
		end
		return data

	end,
	['size']	= function( self, data )
		return table.Count( data )
	end})
	
Ananke.core.serialization:AddTranslation( 
{	['ID']		= 3,
	['type']	= 'number', 
	['Encode']	= function( self, data )
		local s_data = ''
	
		for i = math.ceil(math.log( data ) / math.log( 256 )), 0, -1 do
			if 256^i <= data then
				s_data = s_data .. string.char(math.floor(data/(256^i)))
				data = data - math.floor(data/(256^i))*256^i --Remainder
			end
		end
	
		return s_data
	end,
	['Decode']	= function( self, s_data )
		local tabl = string.explode( '' , s_data )
		local data = 0
		for i = #tabl,0,-1 do
			data = data + string.byte(tabl[1])*(256^i)
		end

		return data
	end,
	['Size']	= function( self, data )
		return math.floor(math.log( data ) / math.log( 256 ))
	end})
	
Ananke.core.serialization:AddTranslation(
{	['ID']		= 4,
	['type'] 	= 'Angle',
	['Encode'] 	= function( self, data )
		local r = ''
		r = r .. self:GetTranslation('number')['Encode'](data.p)
		r = r .. self:GetTranslation('number')['Encode'](data.y)
		r = r .. self:GetTranslation('number')['Encode'](data.r)
		return r
	end,
	['Decode']	= function( s_data )
		local t = string.Explode('' , s_data )
		local tabl = {}
		for i = 1,6,2 do
			local num = t[i] .. t[i+1]
			tabl[i] = (self:GetTranslation('number')['Decode'](num) <= 0) and ((self:GetTranslation('number')['Decode'](num) + 255) or (self:GetTranslation('number')['Decode'](num)))
		end
		local ang = Angle( unpack(tabl) )
		return ang
	end,
	['Size']	= function( data )
		return 3
	end})
	
Ananke.core.serialization:AddTranslation(
{	['ID']		= 5,
	['type']	= 'Vector',
	['Encode']	= function( data )
		local r = ''
		r = r .. self:GetTranslation('number')['Encode'](data.x)
		r = r .. self:GetTranslation('number')['Encode'](data.y)
		r = r .. self:GetTranslation('number')['Encode'](data.z)
		return r
	end,
	['Decode']	= function( s_data )
		local t = string.Explode( '' , s_data )
		local tabl = {}
		for i = 1,6,2 do
			local num = t[i] .. t[i+1]
			tabl[i] = (self:GetTranslation('number')['Decode'](num) <= 0) and (self:GetTranslation('number')['Encode'](num) + 255) or (self:GetTranslation('number')['Decode'](num))
		end
		local vec = Vector( unpack(tabl) )
		return vec
	end,
	['Size']	= function( self, data )
		return 6
	end})
	
Ananke.core.serialization:AddTranslation( 
{	['ID'] 		= 6,
	['type'] 	= 'boolean',
	['Encode'] 	= function( self, data )
		return string.char( data == true and 2 or 1 )
	end,
	['Decode']	= function( self, s_data )
		return string.byte(s_data) == 2 and true or false
	end,
	['Size']	= function( self, data )
		return 1
	end})

