MODULE.Name = 'Chat Commands'
MODULE.Author = 'WARPAC Studios';
MODULE.Contact = 'n/a';
MODULE.Website = 'www.warpac-rp.com';
MODULE.Description = 'Chat command system.'

local _CHATCOMMANDS = {}

chatcommands = {}
chatcommands.__index = {}

chatcommands.prefix = '>'

local function Validate(ply, data)
	if #data < self.data.minargs then
		ply:ChatPrint("Specified too few arguments for "..self.name..". Need "..self.data.minargs)
		return false
	end
	return true
end

function chatcommands.New(command)
	local tabl = {}
	tabl['name'] = command
	tabl['args'] = {}
	tabl['callback'] = function() end
	tabl['precall'] = function(ply, data) return true end -- Should it actually pass?
	tabl['postcall'] = function() end
	tabl['validatecall'] = Validate(ply, data)
	tabl['data']['minargs'] = 0
	return setmetatable(tabl,chatcommands)
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

function chatcommands:SetValidatecall(func)
	self.validatecall = func
end

function chatcommands:SetMinArgs(n)
	self.data.minargs = n
end

function chatcommands:Register()
	_CHATCOMMANDS[self.name] = table.Copy(self)
end

hook.Add('PlayerSay','wp_PlayerSay',function(ply,text,b_team)


	local cmd = text:gsub( "^["..self.prefix.."/](%S+)(.*)", "%1" )
	
	-- check for command
	local command = chatcommands.Get(string.TrimLeft(cmd,chatcommands.prefix))
	if !command then return end
	
	
	-- command exists
	text = text:gsub( "^[!/](%S+)%s*", "" )
	local args = {}
	for v in text:gmatch( "(%S+)" ) do
		table.insert( args, v )
	end
	
	local data = {}
	for k,v in ipairs(command.args) do
		data[k] = args[k] or v[2]
	end
	
	local shouldpass = command.precall(ply, data)
	if !shouldpass then return end
	
	local isvalid = command.validatecall(ply, data)
	if !isvalied then return end
	
	command.callback(data)

	command.postcall()
	
end)
