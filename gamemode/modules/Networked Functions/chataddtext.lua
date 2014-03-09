Ananke.NetworkedFunction.AddChatText = {}

Ananke.NetworkedFunction.AddChatText.Protocol = Ananke.core.protocol.new()

Ananke.NetworkedFunction.AddChatText.Protocol:SetName( "nw_variables" )
Ananke.NetworkedFunction.AddChatText.Protocol:SetPID( 0x03 )
Ananke.NetworkedFunction.AddChatText.Protocol:SetType( NW_STC )		--0x01 - Server to Client
Ananke.NetworkedFunction.AddChatText.Protocol:SetData({ [1] = "table" })


Ananke.NetworkedFunction.AddChatText.Protocol:SetCallBack(function(data)
	chat.AddText(unpack(data))
end)