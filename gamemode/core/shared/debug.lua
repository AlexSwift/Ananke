Ananke.core.debug = {}
Ananke.core.debug.data = {}
Ananke.core.debug.Errors = {}

Ananke.core.debug.enabled = false
Ananke.core.debug.timestamp = Ananke.core.debug.enabled and os.time() or 0

function Ananke.core.debug.Add()

	if !Ananke.core.debug.enabled then return end
	
	local info = debug.getinfo(2, "nSl")
	local i = Ananke.core.debug.data[info.short_src][info.linedefined][1] + 1 or 1
	
	Ananke.core.debug.data[info.short_src] = Ananke.core.debug.data[info.short_src] or {}
	Ananke.core.debug.data[info.short_src][info.linedefined] = Ananke.core.debug.data[info.short_src][info.linedefined] or {}
	Ananke.core.debug.data[info.short_src][info.linedefined] = { i , info , i / (os.time() - Ananke.core.debug.timestamp) }
	
end

function Ananke.core.debug.PrintData(...)

	local args = {...}
	
	if args[1] and Ananke.core.debug.data[args[1]] then
		if args[2] and Ananke.core.debug.data[args[1]][args[2]] then
			return PrintTable(Ananke.core.debug.data[args[1]][args[2]])
		else
			return PrintTable(Ananke.core.debug.data[args[1]])
		end
	else
		return PrintTable(Ananke.core.debug.data)
	end
	
end

function Ananke.core.debug.SetActive( b )

	Ananke.core.debug.enabled = b
	Ananke.core.debug.timestamp = Ananke.core.debug.enabled and os.time() or 0
	
end

function Ananke.core.debug.Error( str , Halt )

	local func = Halt and Error or ErrorNoHalt

	local info = debug.getinfo(2, "nSl")
	table.insert( Ananke.core.debug.Errors , { str , info } )
	
	func( str )
	
end

	
	

