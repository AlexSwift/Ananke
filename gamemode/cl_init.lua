include('shared.lua')
include('core/core.lua')
include('modules/modules.lua')

print("---------")
print("---------")
print("---------")
print("---------")
print("TEST")
print("---------")
print("---------")
print("---------")
print("---------")

function GM:PostDrawViewModel( vm, ply, weapon )

	if ( weapon.UseHands || !weapon:IsScripted() ) then

		local hands = LocalPlayer():GetHands()
		if ( IsValid( hands ) ) then hands:DrawModel() end

	end

end
