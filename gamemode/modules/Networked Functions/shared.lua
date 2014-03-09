MODULE.Name = 'Networked Functions'
MODULE.Author = 'WARPAC Studios';
MODULE.Contact = 'n/a';
MODULE.Website = 'www.warpac-rp.com';
MODULE.Description = 'Networked Functions, more of a util library.'

Ananke.NetworkedFunction = {}

function MODULE:Load()
	Ananke.include(  Ananke.Name .. "/gamemode/modules/Networked Functions/chataddtext.lua" ) 
end