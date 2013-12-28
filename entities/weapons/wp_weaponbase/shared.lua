--[[ Weaponbase for WARPAC by Lenny. ]]
/* Taking inspiration from: The Anathema Weapon Base - Written by wauterboi for the Garry's Mod Community */

SWEP.PrintName			=	"WARPAC Weaponbase example"
SWEP.Author				=	"Lenny, WARPAC-team"
SWEP.Instructions		=	"to be determined."

--[[
	Spawn info
]]

SWEP.Spawnable			=	true
SWEP.AdminOnly			=	true

--[[
	SWEP vars
]]


SWEP.ViewModel          =       "models/weapons/cstrike/c_smg_mp5.mdl" --make sure your models are ready for view model hands
SWEP.WorldModel         =       "models/weapons/w_smg_mp5.mdl"

SWEP.UseHands = true

SWEP.ViewModelFOV = 70 -- this is as high as I could get it without the arms clipping in the screen all the time
SWEP.HoldType = "smg"

SWEP.Primary = {}
SWEP.Primary.Damage = {}
SWEP.Primary.Recoil = {}
SWEP.Primary.Spread = {}

SWEP.Primary.Damage.Value = 13

SWEP.Primary.FireMode = "auto" -- a "auto", "semi-auto" (TODO: add other firemodes)
SWEP.Primary.Automatic = true --placeholder for testing
SWEP.Primary.ClipSize = 30 -- size of clip
SWEP.Primary.FireRate = .1 -- delay between shots in seconds
SWEP.Primary.UnderWater = false -- shoot when in water
SWEP.Primary.Ammo = "smg1"

SWEP.Primary.MuzzleEffect = ""

SWEP.Primary.Spread.Value = .07 -- how much do shots spread
SWEP.Primary.Recoil.Value = 2 -- how much does the view kick up after shooting
SWEP.Primary.Spread.AimReduction = .5 -- how much does the spread decrease whem aiming (in %)
SWEP.Primary.Recoil.AimReduction = .5 -- how much does the recoil decrease whem aiming (in %)

--[[
	SWEP hooks
]]


--init

function SWEP:Initialize()

end

function SWEP:Deploy()
	self:SendWeaponAnim(ACT_VM_DRAW)
	return true
end

function SWEP:Equip(NewOwner)
	self.SetWeaponHoldType(self.HoldType)
	return true
end

function SWEP:PrimaryAttack()
	if !self:CanPrimaryAttack() then
		return
	end
	local spread = self.Primary.Spread.Value
	local recoil = self.Primary.Recoil.Value
	self:ShootBullet(self.Primary.Damage.Value, 1, spread, recoil)
	self:FireEffects(recoil)
	self:TakePrimaryAmmo(1)
end

function SWEP:CanPrimaryAttack()
	if self.Weapon:Clip1() <= 0 then
		return false
	elseif (!self.UnderWater and self.Owner:WaterLevel() > 2) then
		return false
	elseif self:GetNextPrimaryFire() > CurTime() then
		return false
	end

	self:SetNextPrimaryFire(CurTime() + self.Primary.FireRate)

	return true
end

function SWEP:ShootBullet(damage, num, spread, recoil)
	local bullet = {}
	bullet.Attacker = self.Owner
	bullet.Src = self.Owner:GetShootPos()
	bullet.Dir = self.Owner:GetAimVector()
	bullet.Spread = Vector(spread, spread, 0)
	bullet.Num = num
	bullet.Tracer = true
	bullet.AmmoType = self.Primary.Ammo
	bullet.Damage = damage

	self.Owner:FireBullets(bullet)
end

function SWEP:FireEffects(recoil)
	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)

	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self.Owner:MuzzleFlash()

	local upkick = math.Rand(-.4, .15) * recoil --higher chance for upkick than downkick
	local sidekick = math.Rand(-.15, .15) * recoil --low sidekick

	self.Owner:ViewPunch(Angle(upkick, sidekick, 0))
	--self.Owner:SetEyeAngles(self.Owner:EyeAngles() + Angle(upkick, sidekick, 0)) --kyle wants it to be cs:go like :/ so ne real recoil
end

function SWEP:SecondaryAttack() --no, because of iron sights
	return false
end