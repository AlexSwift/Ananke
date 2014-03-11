Ananke.core.profiles = {}
Ananke.core.profiles['types'] = {}
Ananke.core.profiles.__index = profiles

function Ananke.core.profiles.GetByID(id)
	return Entity(id).profile and Entity(id).profile or nil
end

function Ananke.core.profiles.AddDataType( name , ... )
	local args = {...}
	Ananke.core.profiles['types'][name] = args
end