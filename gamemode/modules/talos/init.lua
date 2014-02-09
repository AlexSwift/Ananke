--In Greek mythology, Talos (/ˈtɑːlɵs/; Greek: Τάλως, Talōs) or Talon (/ˈtɑːlɵn/; Greek: Τάλων, Talōn) was a giant man of bronze who protected Europa in Crete from pirates and invaders.
Ananke.talos = {}

Ananke.talos.bans = {}

function Ananke.talos.UpdateBanTable(data)
	Ananke.talos.bans = data
	Ananke.talos.bans.age = CurTime()
end

function Ananke.talos.QueryBanList()
	core.MySQL.Query( "SELECT * FROM bans;", UpdateBanTable)
end
hook.Add("UpdateBanList", "MainFunc", QueryBanList )

timer.Create("BanRefresh", 10, 0, function()
	if (bans.age - CurTime()) > 10 then
		QueryBanList()
	end
end)

function Ananke.talos.IsBanned(id)
	if Ananke.talos.bans.id != nil then
		return true
	else 
		return false
	end
end

function Ananke.talos.IsBanned64(id)
	if Ananke.talos.bans.steamid64 != nil then
		return true
	else 
		return false
	end
end

function Ananke.talos.CheckFamilySharing(body)
	local json = util.JSONToTable(body)
	if json.lender_steamid != 0 then
		if IsBanned64(json.lender_steamid) then
			RunConsoleCommand("kickid", currentlyauthing, "Alt of "..json.lender_steamid)
		end
	end
end

local currentlyauthing = ""
function Ananke.talos.Auth(data)
	if Ananke.talos.data.bot == 1 then return end
	if Ananke.talos.IsBanned(data.networkid) then
		RunConsoleCommand("kickid", data.userid, "You are banned: "..Ananke.talos.bans.id.reason.."\n".."Ban lift date: "..os.date("%A, %D - %T", Ananke.talos.bans.id.unban).." Time remaining: "..os.difftime(os.time(), bans.id.unban)/86400.." days")
		return
	end
	currentlyauthing = data.userid
	http.Fetch("http://api.steampowered.com/IPlayerService/IsPlayingSharedGame/v0001/?key="..Ananke.config.apikey.."&steamid="..util.SteamIDTo64(id).."&appid_playing=4000&format=json", Ananke.talos.CheckFamilySharing)
end

gameevent.Listen("player_connect")
hook.Add("player_connect", "BanCheck", Ananke.talos.Auth)