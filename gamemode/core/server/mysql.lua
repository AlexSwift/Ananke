require('tmysql4')

Ananke.core.MySQL = {}
Ananke.core.MySQL.Database = nil
Ananke.core.MySQL.Authentication = {}
Ananke.core.MySQL.Queries = {}
Ananke.core.MySQL.Loaded = false
Ananke.core.MySQL.InProg = false

function Ananke.core.MySQL.Initialize()
	local host = Ananke.core.MySQL.Authentication['host'] or '127.0.0.1'
	local user = Ananke.core.MySQL.Authentication['user'] or 'root'
	local pass = Ananke.core.MySQL.Authentication['pass'] or ''
	local daba = Ananke.core.MySQL.Authentication['daba'] or 'main'
	local port = Ananke.core.MySQL.Authentication['port'] or 3306

	local Database, err = tmysql.initialize(host, user, pass, daba, port)

	if Database then
		print('[Ananke] Connected to the Mysql Database')
		Ananke.core.MySQL.Loaded = true
		Ananke.core.MySQL.Database = Database
	else
		Ananke.core.Debug.Error( 'Unabled to connect to the Database!' )
	end
end

function Ananke.core.MySQL.Query( q, callback, ...)

	local args = {...}
	local flags, vargs =(args[1] or nil),(args[2] or nil)
	table.insert(Ananke.core.MySQL.Queries, {q, callback, flags, vargs})
	if not Ananke.core.MySQL.InProg then
		Ananke.core.MySQL.Process()
	end
end

function Ananke.core.MySQL.Process()

	if not Ananke.core.MySQL.Loaded then
		--Do a retry timer
		return
	end

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
	Ananke.core.MySQL.Database:Query(Ananke.core.MySQL.Queries[1][1], callback, Ananke.core.MySQL.Queries[1][3], Ananke.core.MySQL.Queries[1][4])
	Ananke.core.MySQL.InProg = true
end

function Ananke.core.MySQL.CollumnNames(DB,tabl,callback)
	local q = "SELECT `COLUMN_NAME` FROM `INFORMATION_SCHEMA`.`COLUMNS` WHERE `TABLE_SCHEMA`='"..DB.."' AND `TABLE_NAME`='"..tabl.."';"
	Ananke.core.MySQL.Query( q, function(data)
		callback(data)
	end)
end

function Ananke.core.MySQL.Insert( name , keys , values )
	local str = "INSERT INTO " .. name
	local str2 = " ( "
	
	for k,v in ipairs( keys ) do
		if k == 1 then str2 = str2 .. v 
		else str2 = str2 .. "," .. v end
	end
	
	str2 = str2 .. " ) VALUES( "

	for k,v in ipairs( values ) do
		if type( v ) == "number" then
			if k == 1 then str2 = str2 .. " " .. v .. ""
			else str2 = str2 .. ", " .. v .. "" end
		else
			if k == 1 then str2 = str2 .. " '" .. tmysql.escape(v) .. "'"
			else
				if ( !tmysql.escape(v) ) then print( "NIL VALUE IN " .. k .. " POSITION", name )
					PrintTable( keys )
					PrintTable( values )
				end
				str2 = str2 .. ", '" .. tmysql.escape(v) .. "'"
			end
		end
	end
	str = str .. str2 .. " )" 
	
	Ananke.core.MySQL.Query( str , function(data)
		--callback(data)
	end)
end