local KeyValues = {} -- [ent] = { key = value }

function GM:EntityKeyValue( ent, key, value )
	
	if not KeyValues[ ent ] then KeyValues[ ent ] = {} end
	
	KeyValues[ ent ][ key ] = value

end

function FindMetaTable( 'Entity' ):GetKeyValue( key )

	if not KeyValues[ self ] then
		return nil
	elseif not KeyValues[ self ][ key ] then
		return nil
	end
	
	return KeyValues[ self ][ key ]
	
end

function FindMetaTable( 'Entity' ):GetKeyValues( )
	
	if not KeyValues[ self ] then
		return { }
	end
	
	return KeyValues[ self ]
	
end

	