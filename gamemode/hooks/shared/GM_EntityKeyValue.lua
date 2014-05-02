local KeyValues = {} -- [ent] = { key = value }

function GM:EntityKeyValue( ent, key, value )
	
	if not KeyValues[ ent ] then KeyValues[ ent ] = {} end
	
	KeyValues[ ent ][ key ] = value

end

function Ananke._ENTITY:GetKeyValue( key )

	if not KeyValues[ self ] then
		return nil
	elseif not KeyValues[ self ][ key ] then
		return nil
	end
	
	return KeyValues[ self ][ key ]
	
end

function Ananke._ENTITY:GetKeyValues( )
	
	if not KeyValues[ self ] then
		return { }
	end
	
	return KeyValues[ self ]
	
end

	