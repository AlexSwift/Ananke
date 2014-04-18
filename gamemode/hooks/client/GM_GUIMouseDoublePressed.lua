function GM:GUIMouseDoublePressed( mousecode, AimVector )
	-- We don't capture double clicks by default, 
	-- We just treat them as regular presses
	GAMEMODE:GUIMousePressed( mousecode, AimVector )
end