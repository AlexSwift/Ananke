local IdleActivity = ACT_HL2MP_IDLE
local IdleActivityTranslate = {}
	IdleActivityTranslate[ ACT_MP_STAND_IDLE ] 					= IdleActivity
	IdleActivityTranslate[ ACT_MP_WALK ] 						= IdleActivity+1
	IdleActivityTranslate[ ACT_MP_RUN ] 						= IdleActivity+2
	IdleActivityTranslate[ ACT_MP_CROUCH_IDLE ] 				= IdleActivity+3
	IdleActivityTranslate[ ACT_MP_CROUCHWALK ] 					= IdleActivity+4
	IdleActivityTranslate[ ACT_MP_ATTACK_STAND_PRIMARYFIRE ] 	= IdleActivity+5
	IdleActivityTranslate[ ACT_MP_ATTACK_CROUCH_PRIMARYFIRE ]	= IdleActivity+5
	IdleActivityTranslate[ ACT_MP_RELOAD_STAND ]		 		= IdleActivity+6
	IdleActivityTranslate[ ACT_MP_RELOAD_CROUCH ]		 		= IdleActivity+6
	IdleActivityTranslate[ ACT_MP_JUMP ] 						= ACT_HL2MP_JUMP_SLAM
	IdleActivityTranslate[ ACT_MP_SWIM ] 						= IdleActivity+9
	IdleActivityTranslate[ ACT_LAND ] 							= ACT_LAND

-- it is preferred you return ACT_MP_* in CalcMainActivity, and if you have a specific need to not tranlsate through the weapon do it here
function GM:TranslateActivity( ply, act )

	local newact = ply:TranslateWeaponActivity( act )

	-- select idle anims if the weapon didn't decide
	if ( act == newact ) then
		return IdleActivityTranslate[ act ]
	end

	return newact

end