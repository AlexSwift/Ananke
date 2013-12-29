Profiles = {}
Profiles.__index = Profiles

Profiles.__Data = { 'Name' }

function Profiles.Initialize()
	for k,v in pairs(Profiles.__Data) do


function Profiles.New()
	return setmetatable({},Profiles)
end

function Profiles:Load(	)

Profiles:SetMoney()
