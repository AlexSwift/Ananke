local plugin = Admin.plugins.New()

plugin.Name = 'Echo'

plugin['args'] = {['p'] = {'string','Default'}}
plugin['callback'] = function(data) print(data['p']) end

plugin:Register()
