--[[	 Datagram Types		]]--

NW_STC 		= 0x01
NW_CTS 		= 0x02
NW_BOTH 	= 0x03

--[[	 Data Structure		]]--

NW_CUSTOM 	= 0x04

--[[	 Data Translation	]]--

NW_TRANSLAITON = {
	['number'] = function(data)
			--[[
				Bit
				Double
				Float
				Int
				Uint
			]]
			return 'Double'
		end,
	['Vector'] = function(data)
			--[[
				Vector
				Normal
			]]
			return 'Vector'
		end,
	['Angle']  = function(data)
			return 'Angle'
		end,
	['Entity'] = function(data)
			return 'Entity'
		end,
	['string'] = function(data)
			return 'String'
		end,
	['table']  = function(data)
			return 'Table'
		end
	}
