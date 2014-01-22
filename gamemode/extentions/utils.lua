utils = {}

function utils.FindPlayersByName(name)
	local results = {}
	for _, v in pairs(player.GetAll()) do
		if string.find(v:name, name) then
			table.insert(results, name)
		end
	end

	if #results < 1 then
		return false
	end

	local names = {}
	for _, v in pairs(results) do
		table.insert(names, v:Name())
	end
	return results, names

end

function utils.TimeFromString(str)
	local coefficients = {
		['y'] = 31556909,
		['mo'] = 2629740,
		['w'] = 604800,
		['d'] = 86400,
		['h'] = 3600,
		['m'] = 60,
		['s'] = 1
	}
	local tabl = {}
	local tabl.total = 0
	for v, k in string.gmatch(str, "(%d+)(%a+)") do
		v = tonumber(v) or 0
		tabl.total = tabl.total + v * coefficients[k]
		
		tabl[k] = v
	end
	return tabl
end
