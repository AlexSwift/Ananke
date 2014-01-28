--In Greek mythology, Talos (/ˈtɑːlɵs/; Greek: Τάλως, Talōs) or Talon (/ˈtɑːlɵn/; Greek: Τάλων, Talōn) was a giant man of bronze who protected Europa in Crete from pirates and invaders.

local bans = {}

local function UpdateBanTable(data)
	bans = data
	bans.age = CurTime()
end

local function QueryBanList()
	core.MySQL.Query( "SELECT * FROM bans;", UpdateBanTable)
end
hook.Add("UpdateBanList", "MainFunc", QueryBanList )

timer.Create("BanRefresh", 10, 0, function()
	if (bans.age - CurTime()) > 10 then
		QueryBanList()
	end
end)

local function IsBanned(id)
	if bans.id != nil then
		return true
	else 
		return false
	end
end

local function IsBanned64(id)
	if bans.steamid64 != nil then
		return true
	else 
		return false
	end
end

local function KickForFamilyAlt(body)
	local json = util.JSONToTable(body)
	local nam = json.personaname
	local id64 = json.steamid
end

local function CheckFamilySharing(body)
	local json = util.JSONToTable(body)
	if json.lender_steamid != 0 then
		if IsBanned64(json.lender_steamid) then
			RunConsoleCommand("kickid", currentlyauthing, "Alt of "..json.lender_steamid)
		end
	end
end

local currentlyauthing = ""
local function Auth(data)
	if data.bot == 1 then return end
	if IsBanned(data.networkid) then
		RunConsoleCommand("kickid", data.userid, "You are banned: "..bans.id.reason.."\n".."Ban lift date: "..os.date("%A, %D - %T", bans.id.unban).." Time remaining: "..os.difftime(os.time(), bans.id.unban)/86400.." days")
		return
	end
	currentlyauthing = data.userid
	http.Fetch("http://api.steampowered.com/IPlayerService/IsPlayingSharedGame/v0001/?key="..ananke.config.apikey.."&steamid="..util.SteamIDTo64(id).."&appid_playing=4000&format=json", CheckFamilySharing)
end

gameevent.Listen("player_connect")
hook.Add("player_connect", "BanCheck", Auth)