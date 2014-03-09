local PLUGIN = Ananke.Admin.plugins.new()

PLUGIN.Name = "kick"

function PLUGIN.Functions.kick(ply, reason)
	ply:Kick(reason)
end

function PLUGIN.CallBack(ply, data)
	local matches, names = utils.FindPlayersByName(data[1])
	if !matches then 
		ply:ChatPrint("Could not match player "..data[1]..".") 
		Ananke.debug.Error(  "Could not match player "..data[1].."." , true )
	end

	if matches > 1 then 
		ply:ChatPrint("Error! Found multiple players with that name: "..table.concat(names))
		return 
	else
		PLUGIN.kick(ply, data[2])
	end
end

PLUGIN:Register()
