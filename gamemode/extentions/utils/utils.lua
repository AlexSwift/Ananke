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