Ananke.core.profiles = {}
Ananke.core.profiles['types'] = {}
Ananke.core.profiles.__index = profiles

function Ananke.core.profiles.GetByID(id)
	return Entity(id).profile
end

function Ananke.core.profiles.AddDataType( name , ... )
	local args = {...}
	Ananke.core.profiles['types'][name] = args
end

function Ananke.core.profiles:Set(key,value)
	self['data'][key] = value
end

function Ananke.core.profiles:Get(key)
	return self['data'][key] or nil
end

