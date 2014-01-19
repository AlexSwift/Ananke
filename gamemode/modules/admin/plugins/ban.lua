local plugin = Admin.plugins.New()

plugin.Name = "ban"



plugin['args'] = {['p'] = {'string','Default'}}
plugin['callback'] = function(data) print(data['p']) end

plugin:Register()
