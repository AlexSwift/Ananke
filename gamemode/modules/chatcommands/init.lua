local _CHATCOMMANDS = {}

chatcommands = {}
chatcommands.__index = {}

chatcommands.prefix = '>'

function chatcommands.New(command)
	local tabl = {}
	tabl['name'] = command
	tabl['args'] = {}
	tabl['callback'] = function() end
	tabl['precall'] = function(ply) return true end -- Should it actually pass?
	tabl['postcall'] = function() end
	return setmetatable({},table.Copy(chatcommands))
end

function chatcommands.Get(command)
	return _CHATCOMMANDS[command] or nil
end

function chatcommands:AddArg(Type,default)
	table.insert(self.args,{Type,default})
end

function chatcommands:SetCallback(func)
	self.callback = func
end

function chatcommands:SetPrecall(func)
	self.precall = func
end

function chatcommands:SetPostcall(func)
	self.postcall = func
end

function chatcommands:Register()
	_CHATCOMMANDS[self.name] = table.copy(self)
end

hook.Add('PlayerSay','wp_PlayerSay',function(ply,text,b_team)

	local tabl = string.explode(" ",text)
	if !string.gsub(tabl[1],1,1) == self.prefix then return end

	local command = chatcommands.Get(string.TrimLeft(tabl[1],'>'))
	if !command then return end

	tabl[1] = nil
	tabl = table.shift(tabl,1) --Remove the '>command' and shift

	local data = {}
	for k,v in ipairs(command.args) do
		data[k] = tabl[k] or v[2]
	end

	local shouldpass = command.precall(ply)
	if !shouldpass then return end

	command.callback(data)

	command.postcall()
end)

