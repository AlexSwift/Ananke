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

function core.serialization.initialize()

	local types = {
		[1] = {'string'	,function( data, s_data ) end},
		[2] = {'table'	,function( data, s_data ) end},
		[3] = {'number'	,function( data, s_data ) end},
		[4] = {'Angle'	,function( data, s_data ) end},
		[5] = {'Vector'	,function( data, s_data ) end}
		}

	for k,v in pairs(types) do
		core.serialization.translations['start_' .. v[1]] = { 2*k - 1 , v[2] }
		core.serialization.translations['end_' .. v[1]] = 2*k
	end

end

function core.serialization.__call(data)
	local t = type(data[1])
	data[2] = data[2] and data[2] .. string.char(core.serialization.translations['start_'..type(data[1])]) or string.char(core.serialization.translations['start_'..type(data[1])])
	core.serialization.translations['start_'..type(data[1])](data[1])
	data[2] = data[2] .. string.char(core.serialization.translations['end_'..type(data[1])])

	return s_data
end

function core.serialization.decode(s_data)

	return data
end

