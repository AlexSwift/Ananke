
profiles = {}
profiles['types'] = {}
profiles.__index = profiles

function profiles.GetByID(id)
	return Entity(id).profile
end

function profiles.AddDataType( name , ... )
	local args = {...}
	profiles['types'][name] = args
end

function profiles:Set(key,value)
	self['data'][key] = value
end

function profiles:Get(key)
	return self['data'][key] or nil
end

