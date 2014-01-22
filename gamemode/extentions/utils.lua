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
	local tabl = {}
	local tabl.total = 0
	for v, k in string.gmatch(str, "(%d+)(%a+)") do
		v = tonumber(v) or 0
		if k == "y" then
			tabl.total = tabl.total + v * 31556909 --ceiled from 31556908.8 when 1 year has 365.242 days
		elseif k == "mo" then
			tabl.total = tabl.total + v * 2629740 --ceiled from 2629739.52 when 1 month has 30.4368 days
		elseif k == "w" then
			tabl.total = tabl.total + v * 604800 --TODO Make a metric-like system for time, it makes no goddamn sense this way
		elseif k == "d" then
			tabl.total = tabl.total + v * 86400
		elseif k == "h" then
			tabl.total = tabl.total + v * 3600
		elseif k == "m" then
			tabl.total = tabl.total + v * 60
		elseif k == "s" then
			tabl.total = tabl.total + v
		else
			continue
		end
		tabl[k] = v
	end
	return tabl
end