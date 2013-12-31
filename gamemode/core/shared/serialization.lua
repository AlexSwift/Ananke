
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
							-- Hard part
						end
						,function( s_data )
							-- Main decode function
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
							print(string.byte(t[#t]))
							return ( (#t - 2)*(255-30) + string.byte(t[#t]) - 31)
						end},
		[4] = {'Angle'	,function( data )
							local r = ''
							r = r .. core.serialization.translations['start_number'][2](data.p) .. string.char(2 * #core.serialization.translations + 1)
							r = r .. core.serialization.translations['start_number'][2](data.y) .. string.char(2 * #core.serialization.translations + 1)
							r = r .. core.serialization.translations['start_number'][2](data.r)
							return r
						end
						,function( s_data )
							local t = string.explode( string.char( 2 * #core.serialization.translations) , s_data )
							local tabl = {}
							for i = 1,3 do
								tabl[i] = core.serialization.translations['number'][2](t[i])
							end
							local ang = Angle( unpack(tabl) )
							return ang
						end},
		[5] = {'Vector'	,function( data )
						end
						,function( s_data )
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
