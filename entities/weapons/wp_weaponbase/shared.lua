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


SWEP.ViewModel          =       "models/weapons/cstrike/c_rif_galil.mdl" --make sure your models are ready for view model hands
SWEP.WorldModel         =       "models/weapons/w_rif_galil.mdl"

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
SWEP.Primary.FireRate = .15 -- delay between shots in seconds
SWEP.Primary.UnderWater = false -- shoot when in water
SWEP.Primary.Ammo = "smg1"

SWEP.Primary.MuzzleEffect = ""

SWEP.IronsightPos = Vector(-6.361, -10.827, 2.72) --make false if there are none
SWEP.IronsightAng = Vector(0, 0, 0)

SWEP.Primary.Spread.Value = .07 -- how much do shots spread
SWEP.Primary.Recoil.Value = 2 -- how much does the view kick up after shooting
SWEP.Primary.Spread.AimReduction = .25 -- how much does the spread decrease whem aiming (in %)
SWEP.Primary.Recoil.AimReduction = .25 -- how much does the recoil decrease whem aiming (in %)

SWEP.Primary.Sound = {}
SWEP.Primary.Sound.name = "wp_weaponbase_sound"
SWEP.Primary.Sound.channel = CHAN_AUTO
SWEP.Primary.Sound.volume = 1
SWEP.Primary.Sound.pitchstart = 100
SWEP.Primary.Sound.pitchend = 100
SWEP.Primary.Sound.sound = "weapons/galil/galil-1.wav"



sound.Add(SWEP.Primary.Sound)



--[[
	SWEP hooks
]]


--init

function SWEP:Initialize()
	self.InIronsights = false
	util.PrecacheSound(SWEP.Primary.Sound.name)
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

	--making you more inaccure when walking/falling/moving
	local velo = self.Owner:GetVelocity():Length()
	velo = velo*.00076 --approximating when the lerp will be 2 when velo is 200 (normal walkign speed)
	velo = Lerp(velo, 1, 7.5)

	spread = spread * velo
	recoil = recoil * velo

	if self.InIronsights then
		spread = spread * self.Primary.Spread.AimReduction
		recoil = recoil * self.Primary.Recoil.AimReduction
	end

	self:ShootBullet(self.Primary.Damage.Value, 1, spread, recoil)
	self:FireEffects(recoil)
	self:TakePrimaryAmmo(1)
end

function SWEP:CanPrimaryAttack()
	if self.Weapon:Clip1() <= 0 then
		self.Weapon:DefaultReload(ACT_VM_RELOAD)
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
	self:EmitSound(self.Primary.Sound.name)

	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self:FireMuzzleEffects()

	local upkick = math.Rand(-.4, .15) * recoil --higher chance for upkick than downkick
	local sidekick = math.Rand(-.15, .15) * recoil --low sidekick

	self.Owner:ViewPunch(Angle(upkick, sidekick, 0))
	self.Owner:SetEyeAngles(self.Owner:EyeAngles() + Angle(upkick*.5, sidekick*.5, 0)) --kyle wants it to be cs:go like :/ so ne real recoil
end

function SWEP:FireMuzzleEffects()
	local vm = self.Owner:GetViewModel()
	local muzzle = vm:GetAttachment(1) -- TODO FIGURE IT OUT

	local muzzlefx = EffectData()
	muzzlefx:SetScale(.2)
	muzzlefx:SetOrigin(muzzle.Pos)
	muzzlefx:SetNormal(muzzle.Ang:Up())

	util.Effect("muzzleflash", muzzlefx)

	if !CLIENT then return end
	local light = DynamicLight(self.Owner:EntIndex())
	light.Brightness = math.Rand(3, 5) -- no round is the same
	light.Decay = 10000
	light.DieTime = CurTime() + .1
	light.Dir = muzzle.Ang:Up()
	light.Pos = muzzle.Pos/*self.Owner:GetShootPos() + 50 * self.Owner:GetAimVector()*/
	light.Size = math.random(100, 125)
	light.Style = 0
	light.r = 255
	light.g = 255
	light.b = 100
end

function SWEP:SecondaryAttack() --no, because of iron sights
	if !self.IronsightPos then 
		return false
	end
	self:Ironsights(!self:Ironsights())
end

function SWEP:Reload()
	if self.Weapon:DefaultReload(ACT_VM_RELOAD) then --only when reloading actually takes place (i.e. clip is not full)
		self:Ironsights(false)
	end
end

function SWEP:Ironsights(change)
	if change != nil then
		self.InIronsights = change
		if self.InIronsights then
			self.BobScale = .5
		else
			self.BobScale = 1
		end
	end

	return self.InIronsights
end

function SWEP:GetViewModelPosition(pos, ang)
	if !self.IronsightPos or !self.InIronsights then
		return pos, ang
	end
	pos = pos + self.IronsightPos.x * ang:Right()
	pos = pos + self.IronsightPos.y * ang:Forward()
	pos = pos + self.IronsightPos.z * ang:Up()

	return pos, ang
	
end

function SWEP:Think()
end