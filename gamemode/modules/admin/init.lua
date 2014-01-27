local modul = modules.new()
modul.name = 'admin'

Admin = {}
Admin.plugins = {}
Admin.plugins.mt = {}
Admin.plugins.mt.__index = Admin.plugins

local _PLUGINS = {}

function Admin.plugins.New()
	local tabl = {}
	table.Name = ''
	return setmetatable(tabl,Admin.plugins.mt)
end

function Admin.plugins.mt:Register()
	_PLUGINS[self.Name] = table.Copy(self)
	local cm = chatcommands.New(self.Name)
	chatcommands.SetCallback(cm, self['callback'])
	chatcommands.SetValidateCall(cm, self['data']['minargs'])
	chatcommands.Register(cm)

end

function Admin.plugins.GetByName(name)
	return _PLUGINS[name]
end

function Admin.plugins.Initialise()

	local f,d = file.Find( GM.Name .. "/gamemode/modules/admin/plugins/*.lua", "LUA" )

	print('\tLoading plugins:')

	for k,v in pairs(f) do
		if SERVER then

			print('\t\tLoading ' .. v)
			do
				AddCSLuaFile( GM.Name .. '/gamemode/modules/admin/plugins/'..v)
				include( GM.Name .. '/gamemode/modules/admin/plugins/'..v)
			end
		else
			print('\t\tLoading ' .. v)
			do
				include(GM.Name .. '/gamemode/modules/admin/plugins/'..v)
			end
		end
	end

end

hook.Add("wp.PostModulesLoad", "wp.PostModulesLoad.Admin", function()

	Admin.plugins.Initialise() --Load all modules.

end)

modul:Register()
