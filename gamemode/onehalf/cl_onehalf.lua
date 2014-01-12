--[[------------------------------------------------
|				This is one half				   |
|				Now find the other				   |
|												   |
------------------------------------------------]]--

do --New Thread

	local b = true
	local i = 0 --Operate at stack level, Not current encirvonment.
		    -- Ideally we would like to know when no level of env i exists, and go up a level.
	local _TEMP

	local OneHalf = {}

	while ( b ) do
		_TEMP = getfenv( i )
		if _TEMP == nil then
			b = false
			local f = function()
				_TEMP = getfenv( i - 1 )
			end
			pcall(f)
			break
		end
		i = i + 1
	end

	OneHalf['fenv'] = _TEMP
	OneHalf['dhooks'] = {}
	OneHalf['hooks'] = {}
	OneHalf['Watch'] = {}
	OneHalf['buffer'] = {}
	OneHalf['config'] = {}
	OneHalf['functions'] = {}
	OneHalf['stack'] = getfenv(0)

	OneHalf['dhooks']['c'] = function( ... ) --function call or line count

		-- We should avoid this, as with line count 'Locals' in thread 2 prim positions are not args

			local args = {...}
			OneHalf['buffer']['c'] = {}
			OneHalf['buffer']['c']['cargs'] = args

			local name, value = _TEMP.debug.getlocal( 2 , 1 )

			OneHalf['buffer']['c']['args'] = { name , value }

			for k,v in _TEMP.pairs( OneHalf['hooks']['c'] ) do
				v( args )
			end

		end

	OneHalf['dhooks']['l'] = function( ... ) --Next Line

			local args = {...}
			OneHalf['buffer']['l'] = args

			for k,v in _TEMP.pairs( OneHalf['hooks']['c'] ) do
				v( args )
			end

		end

	OneHalf['dhooks']['r'] = function( ... ) --function return

			local args = {...}
			OneHalf['buffer']['r'] = args

			for k,v in _TEMP.pairs( OneHalf['hooks']['c'] ) do
				v( _TEMP.unpack(args) )
			end

		end

	_TEMP.__index = function( t , k )
			if k == 'rawset' then --Change rawset to __newindex (byepass bypass)
				return t.__newindex
			end
			if k == 'rawget' then
				return t.__index
			end

			if type( t[ k ] ) == 'function' then
				for k,v in pairs(OneHalf['watch']) do
					if v[1] == t[ k ] then
						if v[3] == 0 then
							v = nil
						else
							v[3] = v[3] != -1 and v[3] - 1 or -1
							v[2](v[1]) --Call callback (precall) to get args and modify them
						end
					end
				end
			end

			return t[ k ]
		end

	_TEMP.__newindex = function( t , k , v )
			t[ k ] = v
		end

	OneHalf['Initialize'] = function()

		for k,v in _TEMP.pairs(OneHalf['dhooks']) do
			_TEMP.debug.sethook( v[1] , k  , v[2] )
			OneHalf['dhooks'][k] = {}
		end

		/*
		OneHalf['functions']['AddHooks']( 'c' , function( ... )
				local args = { ... }
				for k,v in _TEMP.pairs( OneHalf['watch'] ) do
					if args[1] == v[1] then  --Pointer checking
						v[2]( _TEMP.unpack( args ) )
					end
				end
			end)
		*/ --We should try and avoid debug hooks.
		--I will try and do this in the __index metafunc
		setfenv( 1 , _TEMP.setmetatable( { _G = OneHalf['fenv']} , _TEMP ) )
		--Change current Env and not Stack level.

	end

	OneHalf['functions']['AddHooks'] = function ( hook , func, count )
			count = count or -1
			_TEMP.table.insert( OneHalf['hooks'][ hook ] , { func , count } )
		end

	OneHalf['function']['RemoveHook'] = function ( func, hook ) --Need a better way
			for k,v in _TEMP.pairs( OneHalf['hooks'][ hook ] ) do
				if v == func then
					OneHalf['hooks'][ hook ][ k ] = nil
					break
				end
			end
		end

	OneHalf['function']['WatchFunction'] = function ( func , callback , count )
			count = count or -1
			OneHalf['watch'] = { func , callback , count }
		end

	OneHald['function']['GetFuncArgs'] = function( num )
			local args = {}
			for i = 1,num do
				local name, value = _TEMP.debug.getlocal( 2 , i ) --Second thread
				args[name] = value
			end
			return args
		end

	OneHalf['Initialize']()

end
