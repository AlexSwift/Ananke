local plugin = Admin.plugins.New()

plugin.Name = "kick"

local function kick(ply, reason)
	ply:Kick(reason)
end

local function callback(ply, data)
	local matches, names = utils.FindPlayersByName(data[1])
	if !matches then ply:ChatPrint("Could not match player "..data[1]..".") return end

	if matches > 1 then 
		ply:ChatPrint("Error! Found multiple players with that name: "..table.concat(names))
		return end
	else
		kick(ply, data[2])
	end
end

plugin['args'] = {['p'] = {'string','Default'}}
plugin['callback'] = function(data) print(data['p']) end
plugin['data']['minargs'] = 2

plugin:Register()
