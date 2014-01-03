
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
						end},
		[2] = {'table'	,function( data )
							local s_data = ''
							for k,v in ipairs( data ) do

								s_data = s_data and s_data .. string.char(core.serialization.translations['start_string'][1]) or string.char(core.serialization.translations['start_string'][1])
								s_data = s_data .. core.serialization.translations['start_string'][2](k,s_data)
								s_data = s_data .. string.char(core.serialization.translations['end_string'])

								s_data = s_data .. string.char(core.serialization.translations['start_' .. type(v)][1])
								s_data = s_data .. core.serialization.translations['start_' .. type(v)][2](v,s_data)
								s_data = s_data .. string.char(core.serialization.translations['end_' .. type(v)])

								s_data = s_data .. string.char(core.serialization.padding + 1)

							end

							s_data = string.TrimRight( s_data , string.char(core.serialization.padding + 1) )

							return s_data
						end
						,function( s_data )

							local data = {}

							local tabl = string.explode( string.char(core.serialization.padding + 1) , s_data )
							for k,v in ipairs(tabl) do
								local typ = string.byte(string.GetChar( v , 1 ))
								local split = 0

								for i = 1, string.len(v) do
									if string.byte(string.GetChar(v,i)) == typ + 1 then
										split = i
										break
									end
									continue
								end

								local key = core.serialization.translations['start_string'][3](string.sub(v , 2 , split - 1))
								local value = core.serialization.translations[core.serialization.GetTypeFromByte(string.byte(string.GetChar(v,split + 1)))][3](string.sub(v , split + 2 , string.len(v) - 1))

								data[key] = value
							end
							return data

						end},
		[3] = {'number'	,function( data )
							local n = math.floor( (data + core.serialization.padding + 1) / 255 )
							local r = ''
							for i = 1,n do
								r = r .. string.char(255)
							end
							return r .. string.char( math.mod(data + core.serialization.padding + 1, 255 ) )
						end
						,function( s_data )
							local t = string.Explode( '' , s_data )
							return ( (#t - 2)*255 + string.byte(t[#t]) - 31)
						end},
		[4] = {'Angle'	,function( data )
							local r = ''
							r = r .. core.serialization.translations['start_number'][2](data.p) .. string.char(12)
							r = r .. core.serialization.translations['start_number'][2](data.y) .. string.char(12)
							r = r .. core.serialization.translations['start_number'][2](data.r)
							return r
						end
						,function( s_data )
							local t = string.Explode( string.char( 12 ) , s_data )
							local tabl = {}
							for i = 1,3 do
								tabl[i] = (core.serialization.translations['start_number'][3](t[i]) <= 0) and (core.serialization.translations['start_number'][3](t[i]) + 255) or (core.serialization.translations['start_number'][3](t[i]))
							end
							local ang = Angle( unpack(tabl) )
							return ang
						end},
		[5] = {'Vector'	,function( data )
							local r = ''
							r = r .. core.serialization.translations['start_number'][2](data.x) .. string.char(12)
							r = r .. core.serialization.translations['start_number'][2](data.y) .. string.char(12)
							r = r .. core.serialization.translations['start_number'][2](data.z)
							return r
						end
						,function( s_data )
							local t = string.Explode( string.char( 12 ) , s_data )
							local tabl = {}
							for i = 1,3 do
								tabl[i] = (core.serialization.translations['start_number'][3](t[i]) <= 0) and (core.serialization.translations['start_number'][3](t[i]) + 255) or (core.serialization.translations['start_number'][3](t[i]))
							end
							local vec = Vector( unpack(tabl) )
							return vec
						end},
		[6] = {'boolean',function( data )
							return string.char(( data == true and 1 or 0 ) + core.serialization.padding )
						end
						,function( s_data )
							if (string.byte(s_data) == core.serialization.padding) then
								return false
							end
							return true
						end}
		}

	for k,v in pairs(types) do
		core.serialization.translations['start_' .. v[1]] = { 2*k - 1 , v[2] , v[3] }
		core.serialization.translations['end_' .. v[1]] = 2*k
	end

end

function core.serialization.encode(data)
	local t = type(data)
	local s_data = ''
	s_data = s_data and s_data .. string.char(core.serialization.translations['start_'..type(data)][1]) or string.char(core.serialization.translations['start_'..type(data)][1])
	s_data = s_data .. core.serialization.translations['start_'..type(data)][2](data,s_data)
	s_data = s_data .. string.char(core.serialization.translations['end_'..type(data)])

	return s_data
end

function core.serialization.GetTypeFromByte( byte )
	for k,v in pairs(core.serialization.translations) do
		if type(v) == 'number' then continue end
		if v[1] == byte then
			return k
		end
	end
end

function core.serialization.decode(s_data)

	local typ = string.byte(string.GetChar(s_data,1)) --start_type data
	s_data = string.TrimLeft(s_data, string.GetChar(s_data,1) )
	s_data = string.TrimRight(s_data,string.char(string.byte(string.GetChar(s_data,1)) +1))
	local data = {}
	for k,v in pairs(core.serialization.translations) do
		if type(v) == 'number' then continue end
		if v[1] != typ then continue end
		data = v[3](s_data)
	end

	return data
end

core.serialization.initialize()
