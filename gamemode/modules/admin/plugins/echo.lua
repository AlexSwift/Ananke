local plugin = Ananke.Admin.plugins.new()

plugin.Name = 'Echo'

plugin['args'] = {['p'] = {'string','Default'}}
plugin['CallBack'] = function(data) print(data['p']) end

plugin:Register()
