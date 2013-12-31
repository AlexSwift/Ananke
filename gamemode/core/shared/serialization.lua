/*
	Let's think about what we are trying to do before starting anything:
	We need to serialize data into a non human readable string (more compact)
	and allow for decoding.

	Do we want a header ?

	What happens when there is a table ?

	Let's try and work through all these one by one.

	Proposed format:

	for:
		{
			[key] = value,
			[key] = value,
			[key] = {
						[key] = value
					}
		}

	[s_start][entry][dt]key[/dt][dt][value][/dt][/entry][s_end]

	where key, and value are serialized and compressed.
	This perticular example shows this table:
		{
			[key] = value
		}
	But will include hex charactars so it will be more compact than table.TableToString()

	Let's give it a go!
*/

core.serialization = {}
core.serialization.translations = {}
core.serialization.padding = 30

function core.serialization.initialize()

	local types = {
	--	[id]= { types	,encode function,
	--					 decode function
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
							local t = string.explode( '' , s_data )
							return ( #t - 1 + t[#t] )
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
		[6] = {'bool'	,function( data )
							return string.char(( data and 1 or 0 ) + core.serialization.padding )
						end
						,function( s_data )
							if (string.byte(s_data) == core.serialization.padding) then
								return false
							end
							return true
						end}
		}

	for k,v in pairs(types) do
		core.serialization.translations['start_' .. v[1]] = { 2*k - 1 , v[2] }
		core.serialization.translations['end_' .. v[1]] = 2*k
	end

end

function core.serialization.__call(data)
	local t = type(data[1])
	data[2] = data[2] and data[2] .. string.char(core.serialization.translations['start_'..type(data[1])][1]) or string.char(core.serialization.translations['start_'..type(data[1])][1])
	data[2] = data[2] .. core.serialization.translations['start_'..type(data[1])][2](data[1],s_data)
	data[2] = data[2] .. string.char(core.serialization.translations['end_'..type(data[1])])

	return data[2]
end

function core.serialization.decode(s_data)

	return data
end

core.serialization.initialize()
