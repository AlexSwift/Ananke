MODULE.Name = 'Bind System'
MODULE.Author = 'WARPAC Studios';
MODULE.Contact = 'n/a';
MODULE.Website = 'www.warpac-rp.com';
MODULE.Description = 'Bind system. DUH IM ISACC CLARKE'

Ananke.binds = {}
Ananke.binds._BINDS = {}
Ananke.binds._ValidKeys = {
	['KEY_1'] =	KEY_1 ,
	['KEY_2'] = KEY_2 ,
	['KEY_3'] = KEY_3 ,
	['KEY_4'] = KEY_4 ,
	['KEY_5'] = KEY_5 ,
	['KEY_6'] = KEY_6 ,
	['KEY_7'] = KEY_7 ,
	['KEY_8'] = KEY_8 ,
	['KEY_9'] = KEY_9 ,
	['KEY_A'] = KEY_A ,
	['KEY_APOSTROPHE'] = KEY_APOSTROPHE ,
	['KEY_APP'] = KEY_APP ,
	['KEY_B'] = KEY_B ,
	['KEY_BACKQUOTE'] = KEY_BACKQUOTE ,
	['KEY_BACKSLASH'] = KEY_BACKSLASH ,
	['KEY_BACKSPACE'] = KEY_BACKSPACE ,
	['KEY_BREAK'] = KEY_BREAK ,
	['KEY_C'] = KEY_C ,
	['KEY_CAPSLOCK'] = KEY_CAPSLOCK ,
	['KEY_CAPSLOCKTOGG'] = KEY_CAPSLOCKTOGG ,
	['KEY_COMMA'] = KEY_COMMA ,
	['KEY_COUNT'] = KEY_COUNT ,
	['KEY_D'] = KEY_D ,
	['KEY_DELETE'] = KEY_DELETE ,
	['KEY_DOWN'] = KEY_DOWN ,
	['KEY_E'] = KEY_E ,
	['KEY_END']	= KEY_END ,
	['KEY_ENTER'] = KEY_ENTER ,
	['KEY_EQUAL'] = KEY_EQUAL ,
	['KEY_ESCAPE'] = KEY_ESCAPE ,
	['KEY_F'] = KEY_F ,
	['KEY_F1'] = KEY_F1 ,
	['KEY_F10'] = KEY_F10 ,
	['KEY_F11']	= KEY_F11 ,
	['KEY_F12'] = KEY_F12 ,
	['KEY_F2'] = KEY_F2 ,
	['KEY_F3'] = KEY_F3 ,
	['KEY_F4'] = KEY_F4 ,
	['KEY_F5'] = KEY_F5 ,
	['KEY_F6'] = KEY_F6 ,
	['KEY_F7'] = KEY_F7 ,
	['KEY_F8'] = KEY_F8 ,
	['KEY_F9'] = KEY_F9 ,
	['KEY_FIRST'] = KEY_FIRST ,
	['KEY_G'] = KEY_G ,
	['KEY_H'] = KEY_H ,
	['KEY_HOME'] = KEY_HOME ,
	['KEY_I'] = KEY_I ,
	['KEY_INSERT'] = KEY_INSERT ,
	['KEY_J'] = KEY_J ,
	['KEY_K'] = KEY_K ,
	['KEY_L'] = KEY_L ,
	['KEY_LALT'] = KEY_LALT ,
	['KEY_LAST'] = KEY_LAST ,
	['KEY_LBRACKET'] = KEY_LBRACKET ,
	['KEY_LCONTROL'] = KEY_LCONTROL ,
	['KEY_LEFT'] = KEY_LEFT ,
	['KEY_LSHIFT'] = KEY_LSHIFT ,
	['KEY_LWIN'] = KEY_LWIN ,
	['KEY_M'] = KEY_M ,
	['KEY_MINUS'] = KEY_MINUS ,
	['KEY_N'] = KEY_N ,
	['KEY_NONE'] = KEY_N ,
	['KEY_NUMLOCK']	= KEY_NUMLOCK ,
	['KEY_NUMLOCKTOGGLE'] = KEY_NUMLOCKTOGGLE ,
	['KEY_O'] = KEY_O ,
	['KEY_P'] = KEY_P ,
	['KEY_PAD_0'] = KEY_PAD_0 ,
	['KEY_PAD_1'] = KEY_PAD_1 ,
	['KEY_PAD_2'] = KEY_PAD_2 ,
	['KEY_PAD_3'] = KEY_PAD_3 ,
	['KEY_PAD_4'] = KEY_PAD_4 ,
	['KEY_PAD_5'] = KEY_PAD_5 ,
	['KEY_PAD_6'] = KEY_PAD_6 ,
	['KEY_PAD_7'] = KEY_PAD_7 ,
	['KEY_PAD_8'] = KEY_PAD_8 ,
	['KEY_PAD_9'] = KEY_PAD_9 ,
	['KEY_PAD_DECIMAL'] = KEY_PAD_DECIMAL ,
	['KEY_PAD_DIVIDE'] = KEY_PAD_DIVIDE ,
	['KEY_PAD_ENTER'] = KEY_PAD_ENTER ,
	['KEY_PAD_MINUS'] = KEY_PAD_MINUS ,
	['KEY_PAD_MULTIPLY'] = KEY_PAD_MULTIPLY ,
	['KEY_PAD_PLUS'] = KEY_PAD_PLUS ,
	['KEY_PAGEDOWN'] = KEY_PAGEDOWN ,
	['KEY_PAGEUP'] = KEY_PAGEUP ,
	['KEY_PERIOD'] = KEY_PERIOD ,
	['KEY_Q'] = KEY_Q ,
	['KEY_R'] = KEY_R ,
	['KEY_RALT'] = KEY_RALT ,
	['KEY_RBRACKET'] = KEY_RBRACKET ,
	['KEY_RCONTROL'] = KEY_RCONTROL ,
	['KEY_RIGHT'] = KEY_RIGHT ,
	['KEY_RSHIFT'] = KEY_RSHIFT ,
	['KEY_RWIN'] = KEY_RWIN ,
	['KEY_S'] = KEY_S ,
	['KEY_SCROLLLOCK'] = KEY_SCROLLLOCK ,
	['KEY_SCROLLLOCKTOGGLE'] = KEY_SCROLLLOCKTOGGLE ,
	['KEY_SEMICOLON'] = KEY_SEMICOLON ,
	['KEY_SLASH'] = KEY_SLASH ,
	['KEY_SPACE'] = EY_SPACE ,
	['KEY_T'] = KEY_T ,
	['KEY_TAB'] = KEY_TAB ,
	['KEY_U'] = KEY_U ,
	['KEY_UP'] = KEY_UP ,
	['KEY_V'] = KEY_V ,
	['KEY_W'] = KEY_W ,
	['KEY_X'] = KEY_X ,
	['KEY_XBUTTON_A'] = KEY_XBUTTON_A ,
	['KEY_XBUTTON_B'] = KEY_XBUTTON_B ,
	['KEY_XBUTTON_BACK'] = KEY_XBUTTON_BACK ,
	['KEY_XBUTTON_DOWN'] = KEY_XBUTTON_DOWN ,
	['KEY_XBUTTON_LEFT'] = KEY_XBUTTON_LEFT ,
	['KEY_XBUTTON_LEFT_SHOULDER'] = KEY_XBUTTON_LEFT_SHOULDER ,
	['KEY_XBUTTON_LTRIGGER'] = KEY_XBUTTON_LTRIGGER ,
	['KEY_XBUTTON_RIGHT'] = KEY_XBUTTON_RIGHT ,
	['KEY_XBUTTON_RIGHT_SHOULDER'] = KEY_XBUTTON_RIGHT_SHOULDER ,
	['KEY_XBUTTON_RTRIGGER'] = KEY_XBUTTON_RTRIGGER ,
	['KEY_XBUTTON_START'] = KEY_XBUTTON_START ,
	['KEY_XBUTTON_STICK1'] = KEY_XBUTTON_STICK1 ,
	['KEY_XBUTTON_STICK2'] = KEY_XBUTTON_STICK2 ,
	['KEY_XBUTTON_UP'] = KEY_XBUTTON_UP ,
	['KEY_XBUTTON_X'] = KEY_XBUTTON_X ,
	['KEY_XBUTTON_Y'] = KEY_XBUTTON_Y ,
	['KEY_XSTICK1_DOWN'] = KEY_XSTICK1_DOWN ,
	['KEY_XSTICK1_LEFT'] = KEY_XSTICK1_LEFT ,
	['KEY_XSTICK1_RIGHT'] = KEY_XSTICK1_RIGHT ,
	['KEY_XSTICK1_UP'] = KEY_XSTICK1_UP ,
	['KEY_XSTICK2_DOWN'] = KEY_XSTICK2_DOWN ,
	['KEY_XSTICK2_LEFT'] = KEY_XSTICK2_LEFT ,
	['KEY_XSTICK2_RIGHT'] = KEY_XSTICK2_RIGHT ,
	['KEY_XSTICK2_UP'] = KEY_XSTICK2_UP ,
	['KEY_Y'] = KEY_Y ,
	['KEY_Z'] = KEY_Z
}

function Ananke.binds.GetBinds( key ) 
	
	if key and type( key ) == 'string' then
	
		return {Ananke.binds._BINDS[ key ]}
		
	elseif k and type(k) == 'table' then
	
		local t = {}
		
		for k,v in pairs( key ) do -- key = {KEY , KEY , KEY }
			t[ v ] =  Ananke.binds._BINDS[ v ]
		end
		return t 
		
	else
		return Ananke.binds._BINDS
	end
	
end

function Ananke.binds.AddBind( key , identifier , callback )

	if not key or not identifier or not callback then 
		return
	end
	
	for k,v in pairs( Ananke.binds._ValidKeys ) do
	
		if v == key then
			break
		end
		
		Error( 'Key is not valid' )
		return
	
	end
	
	if Ananke.binds.GetBinds( key )[identifier] then
		Error( 'Identifier is not valid' )
		return
	end
	
	Ananke.binds.GetBinds( key )[identifier] = callback

end

function Ananke.binds.RemoveBind( key , identifier )

	for k,v in pairs( Ananke.binds.GetBinds( key ) ) do 
		if k == identifier then
			v = nil
		end
	end
	
end

function MODULE.Hooks.Think( )

	for k,v in pairs( Ananke.binds._ValidKeys ) do
		if input.WasKeyPressed( v ) then
			for k2,v2 in pairs( Ananke.binds.GetBinds( v ) do
				v2( )
			end
		end
	end
	
end)
	