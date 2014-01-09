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

	while ( b ) then
		_TEMP = getfenv( i )
		if _TEMP == nil then
			b = false
			_TEMP = getfenv( i - 1 )
			break
		end
		i = i + 1
	end

	OneHalf['fenv'] = _TEMP
	OneHalf['dhooks'] = {}
	OneHalf['hooks'] = {}
	OneHalf['buffer'] = {}
	OneHalf['config'] = {}
	OneHalf['functions'] = {}

	OneHalf['dhooks']['c'] = function( ... ) --function call or line count

			local args = {...}
			OneHalf['buffer']['c'] = {}
			OneHalf['buffer']['c']['cargs'] = args

			local name, value = _TEMP.debug.getlocal( 2 , 1 )

			OneHalf['buffer']['c']['args'] = { name , value }

			for k,v in _TEMP.pairs( OneHalf['hooks']['c'] )
				v( args )
			end

		end

	OneHalf['dhooks']['l'] = function( ... ) --Next Line

			local args = {...}
			OneHalf['buffer']['l'] = args

			for k,v in _TEMP.pairs( OneHalf['hooks']['c'] )
				v( args )
			end

		end

	OneHalf['dhooks']['r'] = function( ... ) --function return

			local args = {...}
			OneHalf['buffer']['r'] = args

			for k,v in _TEMP.pairs( OneHalf['hooks']['c'] )
				v( args )
			end

		end

	_TEMP.__index = function( t , k )
			return t[ k ]
		end

	_TEMP.__newindex = function( t , k , v )
			t[ k ] = v
		end

	OneHalf['Initialize'] = function()

		setfenv( 1 , _TEMP.setmetatable( { _G = OneHalf['fenv']} , _TEMP )

		for k,v in _TEMP.pairs(OneHalf['dhooks']) do
			OneHalf['hooks'][k] = {}
			_TEMP.debug.sethook( v[1] , k  , v[2] )
		end

	end

	OneHalf['functions']['AddHooks'] = function ( func , hook , count )
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

	OneHalf['Initialize']()

end