core.debug = {}
core.debug.data = {}
core.debug.enabled = false
core.debug.timestamp = core.debug.enabled and os.time() or 0

function core.debug.Add()
	if !core.debug.enabled then return end
	local info = debug.getinfo(2, "nSl")
	core.debug.data[info.short_src] = core.debug.data[info.short_src] or {}
	core.debug.data[info.short_src][info.linedefined] = core.debug.data[info.short_src][info.linedefined] or {}
	local i = core.debug.data[info.short_src][info.linedefined][1] or 0
	i = i + 1
	core.debug.data[info.short_src][info.linedefined] = { i , info , i / (os.time() - core.debug.timestamp) }
end

function core.debug.PrintData(...)
	local args = {...}
	if args[1] and core.debug.data[args[1]] then
		if args[2] and core.debug.data[args[1]][args[2]] then
			return PrintTable(core.debug.data[args[1]][args[2]])
		else
			return PrintTable(core.debug.data[args[1]])
		end
	else
		return PrintTable(core.debug.data)
	end
end

function core.debug.SetActive( b )
	core.debug.enabled = b
	core.debug.timestamp = core.debug.enabled and os.time() or 0
end

