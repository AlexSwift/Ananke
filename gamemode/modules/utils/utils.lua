local modul = modules.new()
modul.name = 'utils'

utils = {}

function utils.Initialise()

end

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

function modul:OnLoad()
	mathsx.Initialise()
end



modul:Register()
