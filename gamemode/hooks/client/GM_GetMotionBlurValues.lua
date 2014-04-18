function GM:GetMotionBlurValues( x, y, fwd, spin )

	-- fwd = 0.5 + math.sin( CurTime() * 5 ) * 0.5

	return x, y, fwd, spin
	
end