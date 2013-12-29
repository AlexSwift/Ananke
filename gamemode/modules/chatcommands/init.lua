chatcommands = {}
chatcommands.__index = {}

function chatcommands.New()
	return setmetatable({},chatcommands)
end
