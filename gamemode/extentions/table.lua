function table.HVIST(tabl,v,k)
	for key,value in pairs(tabl) do
		if value[k] == v then
			return true
		end
	end
	return false
end

function table.shift( tabl , n)
	for k,v in ipairs(tabl) do
		tabl[k-n] = v
	end
	return tabl
end

function table.HasKey( tabl , key )
	for k,v in pairs(tabl) do
		if k == key then return true end
		continue
	end
	return false
end