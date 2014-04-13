local UILAYERS = {
	OVERLAY =		1,
	FOREGROUND =	2,
	MAIN =			3,
	BACKGROUND =	4
};

class 'Enums' {
	static {
		meta {
			__index = function(self, key)
				return self.ENUMS[key]
			end;
			
			__newindex = function(self, key, value)
				self:Add(key, value)
			end;
		};
	
		public {
			ENUMS = {};
			
			Add = function(self, name, enum)
				if type(name) ~= "string" then return end
				if type(enum) ~= "table" then return end
				
				self.ENUMS[name] = enum
			end;
			
			Print = function(self, name)
				local index = 1
				if self[name] != nil then
					for k,v in pairs(self[name]) do
						print(name .. ": " .. k .. " = " .. v)
						index = index + 1
					end
				end
			end;
			
			Test = function(self, value)
				for name,enum in pairs(self.ENUMS) do
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

--Enums['UILAYERS'] = UILAYERS