MODULE.Name = 'Networked Functions'
MODULE.Author = 'WARPAC Studios';
MODULE.Contact = 'n/a';
MODULE.Website = 'www.warpac-rp.com';
MODULE.Description = 'Networked Functions, more of a util library.'

Ananke.NetworkedFunction = {}

function Ananke.NetworkedFunction.Initialise()
	include("chataddtext.lua")
end

function MODULE:Load()
	Ananke.NetworkedFunction.Initialise()
end


