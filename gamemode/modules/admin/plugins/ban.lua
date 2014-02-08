local plugin = Admin.plugins.New()

plugin.Name = "ban"

--active stuff

local function ban(former, ply, length, reason)
	if !ply:IsValid() then former:ChatPrint("The player you entered is invalid") end
	local banlength = utils.TimeFromString(length).total
end

local function callback(ply, data)
	local matches, names = utils.FindPlayersByName(data[1])
	if !matches then ply:ChatPrint("Could not match player "..data[1]..".") return end

	if matches > 1 then 
		ply:ChatPrint("Error! Found multiple players with that name: "..table.concat(names))
		return end
	else
		ban(ply, matches[1], data[2], data[3])
	end
end


--passive stuff

local function MySQLSetup()
	core.MySQL.Query([[CREATE TABLE IF NOT EXISTS `anankebans`.`bans` (
  `steamid` CHAR(25) NOT NULL,
  `steamid64` INT(20) NOT NULL,
  `name` CHAR(50) NULL,
  `unban` INT(12) NOT NULL,
  `reason` TEXT NULL,
  `num` INT(4) NOT NULL DEFAULT 1,
  `altof` CHAR(25) NULL,
  PRIMARY KEY (`steamid`),
  UNIQUE INDEX `steamid_UNIQUE` (`steamid` ASC),
  UNIQUE INDEX `steamid64_UNIQUE` (`steamid64` ASC));
]]))
end
MySQLSetup()

plugin:Register()
