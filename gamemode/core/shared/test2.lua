tabl = {}
tabl.__index = function(t,k)
	if string.sub(k,1,3) == "Set" then
		local func = function(self,v)
			self[string.sub(k,4)] = v
		end
		return func
	end
	if string.sub(k,1,3) == "Get" then
		local func = function(self)
			return self[string.sub(k,4)]
		end
		return func
	end
end

function tabl.New()
	local t = {}
	return setmetatable(t,tabl)
end
