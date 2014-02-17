require( "sourcenet3" )

function _R.Player:GetNetChannel()
	return CNetChan( self:EntIndex() )
end

function _R.Player:SetConVar( name, value )
	local netchan = self:GetNetChannel()
	
	if ( !netchan ) then return end
	
	local buf = netchan:GetReliableBuffer()
	
	buf:WriteUBitLong( net_SetConVar, NET_MESSAGE_BITS )
	buf:WriteByte( 1 )
	buf:WriteString( name )
	buf:WriteString( value )
end