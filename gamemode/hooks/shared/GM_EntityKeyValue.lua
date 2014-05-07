Ananke.KeyValues = {} -- [ent] = { key = value }

function Ananke:EntityKeyValue( ent, key, value )
	
	if not self.KeyValues[ ent ] then self.KeyValues[ ent ] = {} end
	
	self.KeyValues[ ent ][ key ] = value

end

function Ananke._ENTITY:GetKeyValue( key )

	if not Ananke.KeyValues[ self ] then
		return nil
	elseif not Ananke.KeyValues[ self ][ key ] then
		return nil
	end
	
	return Ananke.KeyValues[ self ][ key ]
	
end

function Ananke._ENTITY:GetKeyValues( )
	
	if not Ananke.KeyValues[ self ] then
		return { }
	end
	
	return KeyValues[ self ]
	
end

	