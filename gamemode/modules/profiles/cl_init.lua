include('shared.lua')

function profile:Set(key,value)
	self[key] = value
end

function profile:Get(key)
	return self[key] or nil
end

