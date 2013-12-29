profiles = {}
profiles.__index = profiles

function profiles.GetByID(id)
	return Entity(id).profile
end

