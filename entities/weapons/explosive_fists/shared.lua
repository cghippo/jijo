SWEP.Spawnable            = true
SWEP.AdminSpawnable        = true

SWEP.BounceWeaponIcon  = false

SWEP.Author            = "blah blah blah"
SWEP.Contact        = ""
SWEP.Purpose        = "EAT IT LITTLE SUCKERS"
SWEP.Instructions    = "HAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHA"

if CLIENT then

    SWEP.PrintName = "FISTY BOOMS"            
	
	SWEP.Category  = "BOOM HERE COMES THE BOOM"
	
	SWEP.HoldType = "fist"
	SWEP.ViewModelFOV = 70
	SWEP.ViewModelFlip = false
	SWEP.ViewModel = "models/weapons/fists/v_fists.mdl"
	SWEP.WorldModel = "models/weapons/fists/w_fists.mdl"
	SWEP.ShowViewModel = true
	SWEP.ShowWorldModel = true
	SWEP.ViewModelBoneMods = {}
	SWEP.Slot = 3
    SWEP.SlotPos = 0
    SWEP.DrawAmmo            = false
    SWEP.DrawCrosshair        = true
    SWEP.CSMuzzleFlashes    = false
	
	SWEP.IconLetter = "."
	
end
function SWEP:Initialize()
    self:SetWeaponHoldType("fist")
end
	SWEP.ViewModel = "models/weapons/v_fists.mdl"
	SWEP.WorldModel = "models/weapons/w_fists.mdl"

SWEP.Primary.Sound             = Sound("")
SWEP.Primary.Damage            = .01
SWEP.Primary.Force             = 1
SWEP.Primary.NumShots          = 999
SWEP.Primary.Delay             = .5
SWEP.Primary.Ammo              = "none"
SWEP.Primary.Spread 		   = 0

SWEP.Primary.ClipSize        = -1
SWEP.Primary.DefaultClip    = -1
SWEP.Primary.Automatic        = false

SWEP.Secondary.Sound        = Sound("")
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.IronSightsPos = Vector(0, 0, 0)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.LastPrimaryAttack = 0

function SWEP:PrimaryAttack()
self.Weapon:SetNextPrimaryFire(CurTime() +self.Primary.Delay)

   local trace = self.Owner:GetEyeTrace()

 if trace.HitPos:Distance(self.Owner:GetShootPos()) <= 150 then
 self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
	bullet = {}
	bullet.Num    = 1
	bullet.Src    = self.Owner:GetShootPos()
	bullet.Dir    = self.Owner:GetAimVector()
	bullet.Spread = Vector(0, 0, 0)
	bullet.Tracer = 0
	bullet.Force  = 1
	bullet.Damage = 10000
 self.Owner:FireBullets(bullet) 
 	local laserhit = EffectData()
	laserhit:SetOrigin(trace.HitPos)
	laserhit:SetNormal(trace.HitNormal)
	laserhit:SetScale(0)
	 self.Weapon:EmitSound("weapons/boomherecomestheboom.wav")
 if SERVER then
        local hitposent = ents.Create("info_target")
        local trace = self.Owner:GetEyeTrace()
        local hitpos = trace.HitPos
	local explosioneffect = ents.Create("env_explosion")
        explosioneffect:SetOwner(self:GetOwner())
	explosioneffect:SetPos(hitpos)
	explosioneffect:Spawn()
	explosioneffect:Fire( "explode", "", 0 )
        end

	 util.BlastDamage(self.Weapon,self.Owner, trace.HitPos,85,70)
 else
	self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
 end

end


function SWEP:SecondaryAttack()
self.Weapon:EmitSound("weapons/boomherecomestheboom.wav")
self.Weapon:SetNextPrimaryFire(CurTime() +self.Primary.Delay)
end

function SWEP:Reload()
end
