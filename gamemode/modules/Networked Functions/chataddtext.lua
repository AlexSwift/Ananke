Ananke.nwfuncs.AddChatText = {}

Ananke.nwfuncs.AddChatText.Protocol = Ananke.core.protocol.new()

Ananke.nwfuncs.AddChatText.Protocol:SetName( "nw_variables" )
Ananke.nwfuncs.AddChatText.Protocol:SetPID( 0x03 )
Ananke.nwfuncs.AddChatText.Protocol:SetType( NW_STC )		--0x01 - Server to Client
Ananke.nwfuncs.AddChatText.Protocol:SetData({ [1] = "table" })


Ananke.nwfuncs.AddChatText.Protocol:SetCallBack(function(data)
	chat.AddText(unpack(data))
end)