function GM:PlayerFootstep( ply, vPos, iFoot, strSoundName, fVolume, pFilter )
	
	
	--[[
	-- Draw effect on footdown
	local effectdata = EffectData()
		effectdata:SetOrigin( vPos )
	util.Effect( "phys_unfreeze", effectdata, true, pFilter )
	--]]
	
	--[[
	-- Don't play left foot
	if ( iFoot == 0 ) then return true end
	--]]
	
end