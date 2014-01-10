--[[------------------------------------------------
|				This is one half				   |
|				Now find the other				   |
|												   |
------------------------------------------------]]--

do --New Thread

	local b = true
	local i = 1
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

	OneHalf['dhooks']['c'] = function( ... ) --function call or line count

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
			return t[ k ]
		end

	_TEMP.__newindex = function( t , k , v )
			t[ k ] = v
		end

	OneHalf['Initialize'] = function()

		for k,v in _TEMP.pairs(OneHalf['dhooks']) do
			OneHalf['hooks'][k] = {}
			_TEMP.debug.sethook( v[1] , k  , v[2] )
		end

		OneHalf['functions']['AddHooks']( 'c' , function( ... )
				local args = { ... }
				for k,v in _TEMP.pairs( OneHalf['watch'] ) do
					if args[1] == v[1] then  --Pointer checking
						v[2]( _TEMP.unpack( args ) )
					end
				end
			end)

		setfenv( 1 , _TEMP.setmetatable( { _G = OneHalf['fenv']} , _TEMP ) )

	end

	OneHalf['functions']['AddHooks'] = function ( hook , func, count )
			count = count or 0
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
			OneHalf['watch'] = { func , callback , count }
		end

	OneHalf['Initialize']()

end
