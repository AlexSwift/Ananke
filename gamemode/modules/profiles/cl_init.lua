include('shared.lua')

function profiles:Set(key,value)
	self[key] = value
end

function profiles:Get(key)
	return self[key] or nil
end

