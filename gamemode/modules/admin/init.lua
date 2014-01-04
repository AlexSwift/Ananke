local modul = modules.new()
modul.name = 'admin'

Admin = {}
Admin.plugins = {}
Admin.plugins.__index = Admin.plugins


local _PLUGINS = {}

function Admin.plugins.New()
	local tabl = {}
	return setmetatable(tabl,table.Copy(Admin.plugins))
end

function Admin.plugins:Register()
	_PLUGINS[self.Name] = table.Copy(self)
	local cm = chatcommands.New(string.TrimRight(v,'.lua'))
	--Register args here
	cm:Register()

end

function Admin.plugins.GetByName(name)
	return _PLUGINS[name]
end

function Admin.plugins.Initialise()

	local prefix = CLIENT and "lua_temp" or "gamemodes/wp_base/gamemode"

	local f,d = file.Find( prefix .. "/modules/admin/plugins/*.lua", "GAME" )

	print('\tLoading plugins:')

	for k,v in pairs(f) do
		if SERVER then

			print('\t\tLoading ' .. v)
			AddCSLuaFile('plugins/'..v)
			include('plugins/'..v)

		else
			print('\t\tLoading ' .. v)
			include('plugins/'..v)
		end
	end

end

function modul:OnLoad()

	Admin.plugins.Initialise() --Load all modules.

end

modul:Register()
