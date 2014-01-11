
core.serialization = {}
core.serialization.translations = {}
core.serialization.padding = 30

function core.serialization.initialize()

	local types = {
	--	[id]= { types	,encode function(data),
	--					 decode function(s_data)
	--		}
		[1] = {'string'	,function( data )
							return data
						end
						,function( s_data )
							return s_data
						end
						,function( data )
							return string.len( data )
						end},
		[2] = {'table'	,function( data )
							local s_data = ''
							for k,v in ipairs( data ) do

								s_data = s_data .. core.serialization.encode(k)
								s_data = s_data .. core.serialization.encode(v)

							end

							return s_data
						end
						,function( s_data )

							local data = {}

							local tabl = string.explode( '' , s_data )
							for i = 1 , #tabl do
								local typ = string.GetChar( i )
								local bytes = string.byte(string.GetChar( i + 1))

								local key = core.serialization.translations[core.serialization.GetTypeFromByte( typ )][3](string.sub( s_data, i + 3, i + 2 + bytes ))

								typ = string.GetChar( i + 3 + bytes )
								local bytes2 = string.byte(string.GetChar( i + 4 + bytes))

								local value = core.serialization.translations[core.serialization.GetTypeFromByte( typ )][3](string.sub( s_data, i + 4 + bytes, i + 3 + bytes + bytes2))

								data[key] = value
								i = i + 4 + bytes + bytes2
							end
							return data

						end,
						function( data )
							return table.Count( data )
						end},
		[3] = {'number'	,function( data )
							local s_data = ''

							for i = math.ceil(math.log( data ) / math.log( 256 )), 0, -1 do
								if 256^i <= data then
									s_data = s_data .. string.char(math.floor(data/(256^i)))
									data = data - math.floor(data/(256^i)*256^i)
									continue
								end
							end

							return s_data
						end

						,function( s_data )

							local tabl = string.explode( '' , s_data )
							local data = 0
							for i = #tabl,0,-1 do
								data = data + string.byte(tabl[1])*(256^i)
							end

							return data
						end
						,function( data )
							return math.floor(math.log( data ) / math.log( 256 ))
						end},
		[4] = {'Angle'	,function( data )
							local r = ''
							r = r .. core.serialization.translations['number'][2](data.p)
							r = r .. core.serialization.translations['number'][2](data.y)
							r = r .. core.serialization.translations['number'][2](data.r)
							return r
						end
						,function( s_data )
							local t = string.Explode('' , s_data )
							local tabl = {}
							for i = 1,6,2 do
								local num = t[i] .. t[i+1]
								tabl[i] = (core.serialization.translations['number'][3](num) <= 0) and (core.serialization.translations['number'][3](num) + 255) or (core.serialization.translations['number'][3](num))
							end
							local ang = Angle( unpack(tabl) )
							return ang
						end
						,function( data )
							return 6
						end},
		[5] = {'Vector'	,function( data )
							local r = ''
							r = r .. core.serialization.translations['number'][2](data.x)
							r = r .. core.serialization.translations['number'][2](data.y)
							r = r .. core.serialization.translations['number'][2](data.z)
							return r
						end
						,function( s_data )
							local t = string.Explode( '' , s_data )
							local tabl = {}
							for i = 1,6,2 do
								local num = t[i] .. t[i+1]
								tabl[i] = (core.serialization.translations['number'][3](num) <= 0) and (core.serialization.translations['number'][3](num) + 255) or (core.serialization.translations['number'][3](num))
							end
							local vec = Vector( unpack(tabl) )
							return vec
						end,
						function( data )
							return 6
						end},
		[6] = {'boolean',function( data )
							return string.char( data == true and 2 or 1 )
						end
						,function( s_data )
							return string.byte(s_data) == 2 and true or false
						end,
						function( data )
							return 1
						end}
		}

	for k,v in pairs(types) do
		core.serialization.translations[v[1]] = { k , v[2] , v[3], v[4] }
	end

end

function core.serialization.encode(data)
	local t = type(data)
	local s_data = ''
	s_data = s_data and s_data .. string.char(core.serialization.translations[type(data)][1]) or string.char(core.serialization.translations[type(data)][1]) --types
	s_data = s_data .. core.serialization.translations[type(data)][4](data) --Bytes
	s_data = s_data .. core.serialization.translations[type(data)][2](data,s_data) --Data

	return s_data
end

function core.serialization.GetTypeFromByte( byte )
	for k,v in pairs(core.serialization.translations) do
		if v[1] == byte then
			return k
		end
	end
end

function core.serialization.decode(s_data)
	local data = ''
	-- local typ = -- Get First byte and return Key for decode function
	return data
end

core.serialization.initialize()
