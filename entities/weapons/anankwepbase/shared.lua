--[[ anankwepbase by the Ananke team ~ ]]

--[[Author info]]
SWEP.PrintName = "anankwepbase"
SWEP.Author = "Lenny., Ananke Team"
SWEP.Instructions = "Make gunz with this"

--[[Spawn info]] --only used for debugging in sandbox
SWEP.Spawnable = true
SWEP.AdminOnly = false 


--[[]]----[[]]--[[SWEP Vars]]--[[]]----[[]]--

--[[SWEP appearance]]
SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/cstrike/c_rif_ak47.mdl"
SWEP.WorldModel = "models/weapons/w_rif_ak47.mdl"

SWEP.ViewModelFOV = 70
SWEP.HoldType = "smg"

--[[SWEP primary attack vars]]
SWEP.Primary = {}

SWEP.Primary.FireMode = "auto" --look in the docu for all the ones you can do
SWEP.Primary.Ammo = "smg1"
SWEP.Primary.ClipSize = 30
SWEP.Primary.FireRate = .1 --in seconds (this one is realistic for the ak47 (600 rounds/min))
SWEP.Primary.UnderWater = false

SWEP.Primary.Sound = {}
SWEP.Primary.Sound.name = "anankwepbasesoung"
SWEP.Primary.Sound.channel = CHAN_AUTO
SWEP.Primary.Sound.volume = 1
SWEP.Primary.Sound.pitchstart = 100
SWEP.Primary.Sound.pitchend = 100
SWEP.Primary.Sound.sound = "weapons/ak47/ak47-1.wav"
sound.Add(SWEP.Primary.Sound)

function SWEP:Precache()
	util.PrecacheSound(self.Primary.Sound.name)

	util.PrecacheModel(self.ViewModel)
	util.PrecacheModel(self.WorldModel)
end

