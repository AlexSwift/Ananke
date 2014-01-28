--In Greek mythology, Talos (/ˈtɑːlɵs/; Greek: Τάλως, Talōs) or Talon (/ˈtɑːlɵn/; Greek: Τάλων, Talōn) was a giant man of bronze who protected Europa in Crete from pirates and invaders.
ananke.talos = {}

ananke.talos.bans = {}

function ananke.talos.UpdateBanTable(data)
	ananke.talos.bans = data
	ananke.talos.bans.age = CurTime()
end

function ananke.talos.QueryBanList()
	core.MySQL.Query( "SELECT * FROM bans;", UpdateBanTable)
end
hook.Add("UpdateBanList", "MainFunc", QueryBanList )

timer.Create("BanRefresh", 10, 0, function()
	if (bans.age - CurTime()) > 10 then
		QueryBanList()
	end
end)

function ananke.talos.IsBanned(id)
	if ananke.talos.bans.id != nil then
		return true
	else 
		return false
	end
end

function ananke.talos.IsBanned64(id)
	if ananke.talos.bans.steamid64 != nil then
		return true
	else 
		return false
	end
end

function ananke.talos.CheckFamilySharing(body)
	local json = util.JSONToTable(body)
	if json.lender_steamid != 0 then
		if IsBanned64(json.lender_steamid) then
			RunConsoleCommand("kickid", currentlyauthing, "Alt of "..json.lender_steamid)
		end
	end
end

local currentlyauthing = ""
local function ananke.talos.Auth(data)
	if ananke.talos.data.bot == 1 then return end
	if ananke.talos.IsBanned(data.networkid) then
		RunConsoleCommand("kickid", data.userid, "You are banned: "..ananke.talos.bans.id.reason.."\n".."Ban lift date: "..os.date("%A, %D - %T", ananke.talos.bans.id.unban).." Time remaining: "..os.difftime(os.time(), bans.id.unban)/86400.." days")
		return
	end
	currentlyauthing = data.userid
	http.Fetch("http://api.steampowered.com/IPlayerService/IsPlayingSharedGame/v0001/?key="..ananke.config.apikey.."&steamid="..util.SteamIDTo64(id).."&appid_playing=4000&format=json", ananke.talos.CheckFamilySharing)
end

gameevent.Listen("player_connect")
hook.Add("player_connect", "BanCheck", ananke.talos.Auth)