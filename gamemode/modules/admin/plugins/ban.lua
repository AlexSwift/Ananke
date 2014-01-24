local plugin = Admin.plugins.New()

plugin.Name = "ban"

--active stuff

local function ban(ply, length, reason)
	
end

local function callback(ply, data)
	local matches, names = utils.FindPlayersByName(data[1])
	if !matches then ply:ChatPrint("Could not match player "..data[1]..".") return end

	if matches > 1 then 
		ply:ChatPrint("Error! Found multiple players with that name: "..table.concat(names))
		return end
	else
		ban(ply, data[2], data[3])
	end
end


--passive stuff


local function CheckBan(id)
	local mysqlresult --query for steamid in ban list
	if mysqlresult then
		local tabl = {}
		tabl.reason = mysqlresult.reason
		tabl.data = mysqlresult.unbandate
		tabl.timeleft = 0 --TODO DO THIS!
		return table
	end

	mysqlresult --query for IP
	if mysqlresult then
		local tabl
		tabl.suspecalt = 1
		return tabl
	end
end

local function AuthBan(data)
	if data.bot == 1 then return end

	local bandata = CheckBan(data.networkid)
	if bandata.banned then
		RunConsoleCommand("kickid", data.userid, "You are banned: "..bandata.reason.."\n".."Ban lift date: "..bandata.date.." Time remaining: "..bandata.timeleft)
	elseif bandata.suspecalt then
		--raise alt suspection
	end
end

gameevent.Listen("player_connect")
hook.Add("player_connect", "BanCheck", AuthBan)



plugin['args'] = {['p'] = {'string','Default'}}
plugin['callback'] = function(data) print(data['p']) end
plugin['data']['minargs'] = 3

plugin:Register()
