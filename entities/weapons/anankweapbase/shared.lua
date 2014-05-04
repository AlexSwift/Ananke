--[[ anankwepbase by the Ananke team ~ ]]

if SERVER then
	AddCSLuaFile()
end

--[[Author info]]
SWEP.PrintName 		= "anankwepbase"
SWEP.Author 		= "Lenny., Ananke Team"
SWEP.Instructions 	= "Make gunz with this"

--[[Spawn info]] --only used for debugging in sandbox
SWEP.Spawnable	= true
SWEP.AdminOnly	= false 


--[[]]----[[]]--[[SWEP Vars]]--[[]]----[[]]--

--[[SWEP appearance]]
SWEP.UseHands	= true

SWEP.ViewModel		= "models/weapons/cstrike/c_rif_ak47.mdl"
SWEP.WorldModel		= "models/weapons/w_rif_ak47.mdl"
SWEP.DeploySpeed	= 1

SWEP.ViewModelFOV	= 62
SWEP.HoldType		= "ar2"


SWEP.IronSights = {}

SWEP.IronSights.Enabled	= true
SWEP.IronSights.Pos		= Vector(-6.591, -18.694, 2.94)
SWEP.IronSights.Ang		= Vector(2, 0, 0)


--[[SWEP primary attack vars]]
--SWEP.Primary = {}

SWEP.Primary.Automatic	= true --true == autp, look in the docu for all the other ones you can do
SWEP.Primary.Ammo		= "smg1"
SWEP.Primary.ClipSize	= 30
SWEP.Primary.FireRate	= .1 --delay between shots in seconds (this one is realistic for the ak47 (600 rounds/min))
SWEP.Primary.UnderWater	= false


SWEP.Primary.Sound = {}

SWEP.Primary.Sound.name			= "anankwepbasesoung"
SWEP.Primary.Sound.channel		= CHAN_AUTO
SWEP.Primary.Sound.volume		= 1
SWEP.Primary.Sound.pitchstart	= 100
SWEP.Primary.Sound.pitchend		= 100
SWEP.Primary.Sound.sound		= "weapons/ak47/ak47-1.wav"
sound.Add(SWEP.Primary.Sound)

function SWEP:Precache()
	util.PrecacheSound(self.Primary.Sound.name)

	util.PrecacheModel(self.ViewModel)
	util.PrecacheModel(self.WorldModel)
end

function SWEP:Initialize()
	self:SetWeaponHoldType(self.HoldType)
end

function SWEP:Equip()
	self:SetDeploySpeed(self.DeploySpeed)
end

function SWEP:PrimaryAttack()
	if !self:CanPrimaryAttack() then return end

	self:TakePrimaryAmmo(1)
	self.Weapon:EmitSound(self.Primary.Sound.name)
end

function SWEP:CanPrimaryAttack()
	if !self.UnderWater and self.Owner:WaterLevel() > 2 then return false end

	if self.Weapon:Clip1() <= 0 then
		self.Weapon:Reload()
		return false
	end
	self:SetNextPrimaryFire(CurTime() + self.Primary.FireRate)
	return true
end

SWEP.IronSights.Active	= false
function SWEP:SecondaryAttack()
	if !self.IronSights.Enabled then return false end
	if !IsFirstTimePredicted() then return false end

	if self.IronSights.Active then
		self:LeaveIronSights()
	else
		self:EnterIronSights()
	end

	return true
end

SWEP.IronSights.EnterTime	= 0
SWEP.IronSights.EnterAng	= Angle(0, 0, 0)
function SWEP:EnterIronSights()
	self.IronSights.Active = true
	self.IronSights.EnterTime = CurTime()
end

function SWEP:LeaveIronSights()
	self.IronSights.Active = false
end

function SWEP:GetViewModelPosition(pos, ang)
	if !self.IronSights.Active then return pos, ang end	
	local GoalPos = pos
	GoalPos = GoalPos + self.IronSights.Pos.x * ang:Right()
	GoalPos = GoalPos + self.IronSights.Pos.y * ang:Forward()
	GoalPos = GoalPos + self.IronSights.Pos.z * ang:Up()

	local GoalAng = ang

	percent = (CurTime() - self.IronSights.EnterTime) / .2
	if percent > 1 then percent = 1 end

	pos = LerpVector(percent, pos, GoalPos)

	return pos, ang
end