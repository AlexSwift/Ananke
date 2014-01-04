--[[ Weaponbase for WARPAC by Lenny. ]]
/* Taking inspiration from: The Anathema Weapon Base - Written by wauterboi for the Garry's Mod Community */


--lua_run to give the weapon+ammo: lua_run local ply = player.GetAll()[1] ply:Give("wp_weaponbase") ply:SetAmmo(5000, "smg1")

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

SWEP.Primary.Spread.Value = 1 -- how much do shots spread
SWEP.Primary.Recoil.Value = .07 -- how much does the view kick up after shooting
SWEP.Primary.Spread.AimReduction = .75 -- how much does the spread decrease whem aiming (in %)
SWEP.Primary.Recoil.AimReduction = .50 -- how much does the recoil decrease whem aiming (in %)
SWEP.Primary.Spread.CrouchReduction = .75 -- how much does the spread decrease whem crouching (in %)
SWEP.Primary.Recoil.CrouchReduction = .50 -- how much does the recoil decrease whem crouching (in %)


SWEP.Primary.Sound = {}
SWEP.Primary.Sound.name = "wp_weaponbase_sound"
SWEP.Primary.Sound.channel = CHAN_AUTO
SWEP.Primary.Sound.volume = 1
SWEP.Primary.Sound.pitchstart = 100
SWEP.Primary.Sound.pitchend = 100
SWEP.Primary.Sound.sound = "weapons/galil/galil-1.wav"


sound.Add(SWEP.Primary.Sound)



local InAttackSince = false
local selfowner = selfowner or nil

function SWEP:Lerp( delta, from, to )
  
  --if ( delta > 1 ) then return to end
  --if ( delta < 0 ) then return from end

  return from + (to - from) * delta;

end



--[[
	SWEP hooks
]]


--init

function SWEP:Initialize()
	self.InIronsights = false
	util.PrecacheSound(self.Primary.Sound.name)
	if SERVER then
		self.flashlight = ents.Create("env_projectedtexture")
	end
	selfowner = self.Owner
end

function SWEP:Deploy()
	if SERVER then
	self.flashlight = ents.Create("env_projectedtexture")

	self.vm = self.Owner:GetViewModel()
	self.muzzle = self.vm:GetAttachment(1)

	--self.flashlight:SetParent(vm)
	--self.flashlight:SetLocalPos(self.muzzle.Pos-self.vm:GetPos())
	--self.flashlight:SetLocalAngles(self.muzzle.Ang-self.vm:GetAngles())
	self.flashlight:SetPos(self.Owner:GetShootPos())

	self.flashlight:SetKeyValue("enableshadows", 1 )
	self.flashlight:SetKeyValue("farz", 300.0 )
	self.flashlight:SetKeyValue("nearz", 1.0 )
	self.flashlight:SetKeyValue("lightfov", 90)
	self.flashlight:SetKeyValue("lightcolor", Format("%i %i %i 200", 255, 255, 100))


	self.flashlight:Spawn()
	self.flashlight:Input("TurnOff")
	self.flashlight:Input("FOV", NULL, NULL, "90")
	self.flashlight:Input("SpotlightTexture", NULL, NULL, "effects/flashlight/soft")
	end

	self:SendWeaponAnim(ACT_VM_DRAW)
	return true
end

function SWEP:Equip(NewOwner)

	self:SetWeaponHoldType(self.HoldType)

	return true
end

function SWEP:PrimaryAttack()
	if !self:CanPrimaryAttack() then
		InAttackSince = false
		return
	end

	if InAttackSince == false then
		InAttackSince = CurTime()
	end

	local spread = self.Primary.Spread.Value
	local recoil = self.Primary.Recoil.Value

	--making you more inaccure when walking/falling/moving
	local velo = self.Owner:GetVelocity():Length()
	velo = velo*.005 -- nomral walkign speed is 200 so normally velo/200 but multiplcation is faster than division so we turn it into multiplcation
	velo = self:Lerp(velo, 1, 2) -- make it twice as high wenn walking

	spread = spread * velo
	recoil = recoil * velo

	if self.InIronsights then
		spread = spread * (1 - self.Primary.Spread.AimReduction)
		recoil = recoil * (1 - self.Primary.Recoil.AimReduction)
	end

	if self.Owner:Crouching() then
		spread = spread * (1 - self.Primary.Spread.CrouchReduction)
		recoil = recoil * (1 - self.Primary.Spread.CrouchReduction)
	end

	if InAttackSince then
		local ShootingTime = CurTime() - InAttackSince
		
		ShootingTime = ShootingTime  -- make sure it's always bigger than 1 since we are dealing with exponents


		spread = spread * math.pow(ShootingTime, 2) * .5
		recoil = recoil * math.pow(ShootingTime, 2) * .5

		local spct = spread/.07
		local rpct = recoil/.07
		spread = Lerp(spct, 0, .07)
		recoil = Lerp(rpct, .3, .75) -- limiting the spread/recoil
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

	self.vm = self.Owner:GetViewModel()
	self.muzzle = self.vm:GetAttachment(1)

	local bullet = {}
	bullet.Attacker = self.Owner
	bullet.Src = self.Owner:GetShootPos()
	bullet.Dir = self.Owner:GetAimVector()
	bullet.Spread = Vector(spread*.75, spread, 0)
	bullet.Num = num
	bullet.Tracer = true
	bullet.AmmoType = self.Primary.Ammo
	bullet.Damage = damage

	self.Owner:FireBullets(bullet)
end

function SWEP:FireEffects(recoil)
	if IsFirstTimePredicted() then
		self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
		self:EmitSound(self.Primary.Sound.name)
	end

	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self:FireMuzzleEffects()

	local upordown = math.random(-1, 1)
	local leftorright = math.random(0, 1)

	if upordown >= 0 then --higher change for up recoil up = 1, down = -1
		upordown = 1
	end
	if leftorright == 0 then -- same chance for both
		leftorright = -1
	end


	local upkick = upordown * recoil --higher chance for upkick than downkick
	local sidekick = leftorright * recoil --low sidekick

	self.Owner:ViewPunch(Angle(sidekick, upkick, sidekick * .25))
	if !CLIENT then return end
	--self.Owner:SetEyeAngles(self.Owner:EyeAngles() + Angle(upkick*.25, sidekick*.25, 0)) --kyle wants it to be cs:go like :/ so no real recoil (but we do it a tiny bit anyway)
end

function SWEP:FireMuzzleEffects()
	self.vm = self.Owner:GetViewModel()
	self.muzzle = self.vm:GetAttachment(1)


	local muzzlefx = EffectData()
	muzzlefx:SetScale(.2)
	muzzlefx:SetOrigin(self.muzzle.Pos)
	muzzlefx:SetNormal(self.muzzle.Ang:Up())

	util.Effect("muzzleflash", muzzlefx)


	if CLIENT then

	local light = DynamicLight(self.Owner:EntIndex())
	light.Brightness = math.Rand(3, 5) -- no round is the same
	light.Decay = 10000
	light.DieTime = CurTime() + .1
	light.Dir = self.muzzle.Ang:Up()
	light.Pos = self.muzzle.Pos/*self.Owner:GetShootPos() + 50 * self.Owner:GetAimVector()*/
	light.Size = math.random(100, 125)
	light.Style = 0
	light.r = 255
	light.g = 255
	light.b = 100

	else
		self.vm = self.Owner:GetViewModel()
		self.muzzle = self.vm:GetAttachment(1)
		self.flashlight:SetPos(self.muzzle.Pos + Vector( 0, 0, 50))
		self.flashlight:SetAngles(self.muzzle.Ang:Up():Angle())
		self.flashlight:SetKeyValue("lightcolor", "255 255 150 255")
		self.flashlight:Input("TurnOn")
		timer.Simple(.001, function()
			self.flashlight:Input("TurnOff")
		end)
	end
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

function SWEP:ViewModelDrawn()
	/*local vm = self.Owner:GetViewModel()
	local att = vm:GetAttachment(2)
	local Vec = vm:GetBonePosition(33)
	local Ang = vm:GetBoneMatrix(33):GetAngles()
	for i = 1,  50 do
		--print(i..": "..vm:GetBoneName(i))
	end
	Ang = Angle(Ang.pitch, Ang.yaw+-10, Ang.roll+90)
	Vec =  Vec + Ang:Up() * -5   + Ang:Right() * -13  + Ang:Forward() * 5
	print(Vec:ToScreen().x.." "..Vec:ToScreen().y )
	cam.Start3D2D(Vec, Ang, 2)

	draw.RoundedBox(1, 0, 0, 10, 10, Color(0, 255, 0))
	draw.DrawText(self.Weapon:Clip1(), "default", 0, 0, Color(255, 0, 0), TEXT_ALIGN_CENTER)


	cam.End3D2D()	*/ -- FUCK THIS
end

function SWEP:Think()
	selfowner = self.Owner --fucking ugly
end

function KeyRelease(ply, key)
	if selfowner == ply then
		if key == IN_ATTACK then
			timer.Simple(.5, function() -- make sure you can't avoid it by tapping
				InAttackSince =  false
			end)
		end
	end
end

hook.Add("KeyRelease", "WPBASEKeyRelease", KeyRelease)