function Ananke:EntityRemoved( ent )

	if self.KeyValues[ ent ] then
		self.KeyValues[ ent ] = nil
	end

end