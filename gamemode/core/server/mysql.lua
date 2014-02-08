require('tmysql4')

Ananke.core.MySQL = {}
Ananke.core.MySQL.Authentication = {}
Ananke.core.MySQL.Queries = {}
Ananke.core.MySQL.Loaded = false
Ananke.core.MySQL.InProg = false

function core.MySQL.Initialize()
	local host = Ananke.core.MySQL.Authentication['host'] or '127.0.0.1'
	local user = Ananke.core.MySQL.Authentication['user'] or 'root'
	local pass = Ananke.core.MySQL.Authentication['pass'] or ''
	local daba = Ananke.core.MySQL.Authentication['daba'] or 'main'
	local port = Ananke.core.MySQL.Authentication['port'] or 3306

	tmysql.initialize(host, user, pass, daba, port)

	--Test query to check if connected?

	core.MySQL.Loaded = true
end

function Ananke.core.MySQL.Query( q, callback, ...)
	local args = {...}
	local flags, vargs =(args[1] or nil),(args[2] or nil)
	table.insert(Ananke.core.MySQL.Queries, {q, callback, flags, vargs})
	if not core.MySQL.InProg then
		Ananke.core.MySQL.Process()
	end
end

function core.MySQL.Process()

	local function callback(...)
		local tabl = {...}
		Ananke.core.MySQL.Queries[1][2](unpack(tabl))
		Ananke.core.MySQL.Queries[1] = nil
		table.shift( Ananke.core.MySQL.Queries , 1)
		if Ananke.core.MySQL.Queries[1] != nil then
			Ananke.core.MySQL.Process()
		else
			Ananke.core.MySQL.InProg = false
		end
	end
	tmysql.query(Ananke.core.MySQL.Queries[1][1], callback, Ananke.core.MySQL.Queries[1][3], Ananke.core.MySQL.Queries[1][4])
	Ananke.core.MySQL.InProg = true
end

function core.MySQL.CollumnNames(DB,tabl,callback)
	local q = "SELECT `COLUMN_NAME` FROM `INFORMATION_SCHEMA`.`COLUMNS` WHERE `TABLE_SCHEMA`='"..DB.."' AND `TABLE_NAME`='"..tabl.."';"
	Ananke.core.MySQL.Query( q, function(data)
		callback(data)
	end)
end

