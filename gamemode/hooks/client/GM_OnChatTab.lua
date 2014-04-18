function GM:OnChatTab( str )

	local LastWord
	for word in string.gmatch( str, "%a+" ) do
	     LastWord = word;
	end
	
	if (LastWord == nil) then return str end
	
	playerlist = player.GetAll()
	
	for k, v in pairs( playerlist ) do
		
		local nickname = v:Nick()
		
		if ( string.len(LastWord) < string.len(nickname) &&
			 string.find( string.lower(nickname), string.lower(LastWord) ) == 1 ) then
				
			str = string.sub( str, 1, (string.len(LastWord) * -1) - 1)
			str = str .. nickname
			return str
			
		end		
		
	end
		
	return str;

end