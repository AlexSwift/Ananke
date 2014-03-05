AddCSLuaFile("shared.lua")
AddCSLuaFile("chataddtext.lua")

include("shared.lua")

local plymeta = FindMetaTable("Player")

plymeta.oldChatPrint = plymeta.ChatPrint

function plymeta:ChatPrint(data)
	if istable(data) then
		local nw = network.New()
		nw:SetProtocol(0x03)
		nw:SetDescription("Networked chat.AddText()")
		nw:pushdata(data)
		nw:send()
	else
		return self:oldChatPrint(data)
	end
end