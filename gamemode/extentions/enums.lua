local enums = {}

local UILAYERS = {
	OVERLAY =		0x0001,
	FOREGROUND =	0x0002,
	MAIN =			0x0004,
	BACKGROUND =	0x0008
};

class 'Enums' {
	
	meta {
		__index = function(self, key)
			return enums[key]
		end;
	};
	
	public {
		static {
			Add = function(self, enum, name)
				if type(enum) != "table" then return end
				if type(name) != "string" then return end
				
				enums[name] = enum
			end;
			
			Print = function(self, name)
				local index = 1
				if enums[name] != nil then
					for k,v in pairs(enums[name]) do
						print(name .. ": " .. k .. " = " .. v)
						index = index + 1
					end
				end
			end;
			
			Test = function(self, value)
				for name,enum in pairs(enums) do
					for k,v in pairs(enum) do
						if enum[value] == v then
							print(value .. " was found in enum[" .. name .. "] with value: " .. enum[value])
							return
						end
					end
				end
				
				print("No enum value named " .. value .. " was found in the enumeration table.")
			end;
		};
	};
};

Enums:Add(UILAYERS, 'UILAYERS')