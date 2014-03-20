function string.Indentation( n )

	local str = ''
	
	for i = 1, n do
		str = str .. '\t'
	end
	
	return str
	
end