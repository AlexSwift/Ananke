local plugin = Admin.plugins.New()

plugin['args'] = {['p'] = {'string','Default'}}
plugin['callback'] = function(data) print(data['p']) end

Admin.plugins:Register()
