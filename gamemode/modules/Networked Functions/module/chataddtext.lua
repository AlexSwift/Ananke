Ananke.NetworkedFunction.AddChatText = {}

Ananke.NetworkedFunction.AddChatText._ChatPrint = FindMetaTable("Player").ChatPrint

Ananke.NetworkedFunction.AddChatText.Protocol = Ananke.core.protocol.new()
Ananke.NetworkedFunction.AddChatText.Protocol:SetName( "nw_variables" )
Ananke.NetworkedFunction.AddChatText.Protocol:SetPID( 0x04 )
Ananke.NetworkedFunction.AddChatText.Protocol:SetType( NW_STC )		--0x01 - Server to Client
Ananke.NetworkedFunction.AddChatText.Protocol:SetData({ [1] = "table" })


Ananke.NetworkedFunction.AddChatText.Protocol:SetCallBack(function(data)
	if not CLIENT then return end
	chat.AddText(unpack(data))
end)

function FindMetaTable("Player"):ChatPrint(data)

	if type( data ) == 'table' and SERVER then
	
		local nw = network.New()
		nw:SetProtocol(0x04)
		nw:SetDescription("Networked chat.AddText()")
		nw:pushdata(data)
		nw:send()
		
	elseif type( data ) == 'table' then
		chat.AddText(unpack(data))
	else
		return Ananke.NetworkedFunction.AddChatText._ChatPrint( data )
	end
end