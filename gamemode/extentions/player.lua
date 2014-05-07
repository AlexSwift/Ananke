function Ananke._PLAYER:IsJumping( )
	
	return self.m_bJumping == true or false
	
end

function Ananke._PLAYER:GetJumpingData( )

	return { self.m_bJumping, self.m_bFirstJumpFrame, m_flJumpStartTime }
	
end

function Ananke._PLAYER:WasOnGround( )
	
	return m_bWasOnGround == true or false
	
end

function Ananke._PLAYER:WasNocliping( )
	
	return m_bWasNoclipping == true or false
	
end

function Ananke._PLAYER:GetCurrentAnim( )

	return self.CalcIdeal

end