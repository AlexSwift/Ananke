Ananke.core.debug = {}
Ananke.core.debug.data = {}
Ananke.core.debug.data.Errors = {}
Ananke.core.debug.data.Logs = {}
Ananke.core.debug.data.Stack = {}

Ananke.core.debug.enabled = false
Ananke.core.debug.timestamp = Ananke.core.debug.enabled and os.time() or 0

DEBUG_PRINT = 1
DEBUG_ERROR = 2
DEBUG_ERRORNOHALT = 3

function Ananke.core.debug.Add()

	if !Ananke.core.debug.enabled then return end
	
	local info = debug.getinfo(2, "nSl")
	local i = Ananke.core.debug.data.Stack[info.short_src][info.linedefined][1] + 1 or 1
	
	Ananke.core.debug.data.Stack[info.short_src] = Ananke.core.debug.data[info.short_src] or {}
	Ananke.core.debug.data.Stack[info.short_src][info.linedefined] = Ananke.core.debug.data[info.short_src][info.linedefined] or {}
	Ananke.core.debug.data.Stack[info.short_src][info.linedefined] = { i , info , i / (os.time() - Ananke.core.debug.timestamp) }
	
end

function Ananke.core.debug.PrintData(...)

	local args = {...}
	
	if args[1] and Ananke.core.debug.data.Stack[args[1]] then
		if args[2] and Ananke.core.debug.data.Stack[args[1]][args[2]] then
			return PrintTable(Ananke.core.debug.data.Stack[args[1]][args[2]])
		else
			return PrintTable(Ananke.core.debug.data.Stack[args[1]])
		end
	else
		return PrintTable(Ananke.core.debug.data.Stack)
	end
	
end

function Ananke.core.debug.SetActive( b )

	Ananke.core.debug.enabled = b
	Ananke.core.debug.timestamp = Ananke.core.debug.enabled and os.time() or 0
	
end

function Ananke.core.debug.Error( str , Halt )

	local func = Halt and Error or ErrorNoHalt

	local info = debug.getinfo(2, "nSl")
	table.insert( Ananke.core.debug.data.Errors , { str , info } )
	
	func( str )
	
end

function Ananke.core.debug.Print( str , type )

	if type == DEBUG_PRINT then
		print( '[Ananke] ' .. str )
	elseif type == DEBUG_ERROR then
		error( '[Ananke] ' .. str )
	elseif type == DEBUG_ERRORNOHALT then
		ErrorNoHalt( '[Ananke] ' .. str )
	end
	
end

function Ananke.core.debug.Log( str , data, push )
	
	table.insert( Ananke.core.debug.data.Logs, { str , data } )
	
	if push then
		Ananke.core.debug.Print( str , push )
	end
	
end
	
	

