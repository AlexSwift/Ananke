nwfuncs.AddChatText = {}

if SERVER then

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

end

nwfuncs.AddChatText.Protocol = Ananke.core.protocol.new()

nwfuncs.AddChatText.Protocol:SetName( "nw_variables" )
nwfuncs.AddChatText.Protocol:SetPID( 0x03 )
nwfuncs.AddChatText.Protocol:SetType( NW_STC )		--0x01 - Server to Client
nwfuncs.AddChatText.Protocol:SetData( "table" )


nwfuncs.AddChatText.Protocol:SetCallBack(function(data)
	chat.AddText(unpack(data))
end)

nwfuncs.AddChatText.Protocol:SetSend(function(data)
	net.WriteTable(data)
end)

nwfuncs.AddChatText.Protocol:SetReceive(function()
	return net.ReadTable()
end)