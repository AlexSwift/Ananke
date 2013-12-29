require('tmysql4')

core.MySQL = {}
core.MySQL.Authentication = {}
core.MySQL.Queries = {}
core.MySQL.Loaded = false
core.MySQL.InProg = false

function core.MySQL.Initialize()
	local host = core.MySQL.Authentication['host'] or '127.0.0.1'
	local user = core.MySQL.Authentication['user'] or 'root'
	local pass = core.MySQL.Authentication['pass'] or ''
	local daba = core.MySQL.Authentication['daba'] or 'main'
	local port = core.MySQL.Authentication['port'] or 3306

	tmysql.initialize(host, user, pass, daba, port)

	--Test query to check if connected?

	core.MySQL.Loaded = true
end

function core.MySQL.Query( q, callback, ...)
	local flags, vargs =({...}[1] or nil),({...}[2] or nil)
	table.insert(core.MySQL.Queries, {q, callback, flags, vargs})
	if not core.MySQL.InProg then
		core.MySQL.Process()
	end
end

local function table.shift( tabl , n)
	for k,v in ipairs(tabl) do
		tabl[k-n] = v
	end
	return tabl
end

function core.MySQL.Process()
	table.shift( core.MySQL.Queries , 1)
	if core.MySQL.Queries[1] == nil then
		core.MySQL.InProg = false
		return
	end
	local function callback(...)
		local tabl = {...}
		core.MySQL.Process()
		core.MySQL.Queries[1][2](unpack(tabl))
	end
	tmysql.query(core.MySQL.Queries[1][1], callback, core.MySQL.Queries[1][3], core.MySQL.Queries[1][4])
	core.MySQL.InProg = true
end

function core.MySQL.CollumnNames(DB,tabl,callback)
	local q = "SELECT `COLUMN_NAME` FROM `INFORMATION_SCHEMA`.`COLUMNS` WHERE `TABLE_SCHEMA`='"..DB.."' AND `TABLE_NAME`='"..tabl.."';"
	core.MySQL.Query( q, function(data)
		callback(data)
	end)
end

