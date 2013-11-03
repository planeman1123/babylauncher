SWEP.PrintName			= "Baby/Melon Thrower"			
SWEP.Author			= "The Wise Sloth"
SWEP.Instructions		= "Left mouse to fire a baby, right to fire a melon!"

SWEP.Spawnable = true
SWEP.AdminOnly = true

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= true
SWEP.Secondary.Ammo		= "none"

SWEP.Weight			= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Slot			= 1
SWEP.SlotPos			= 2
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= true

SWEP.ViewModel			= "models/weapons/v_rpg.mdl"
SWEP.WorldModel			= "models/weapons/w_rocket_launcher.mdl"

function SWEP:PrimaryAttack()

	self.Weapon:SetNextPrimaryFire( CurTime() + 0.1 )	


	self:ThrowBaby( "models/props_c17/doll01.mdl" )

end
 


local ShootSound = Sound( "Weapon_mac10.Single" )

function SWEP:SecondaryAttack()
	
	self.Weapon:SetNextSecondaryFire( CurTime() + 0.1 )	

	self:ThrowMelon( "models/props_junk/watermelon01.mdl" )

end

function SWEP:ThrowBaby( model_file )

	self:EmitSound( ShootSound )
 
	if ( CLIENT ) then return end

	local ent = ents.Create( "prop_physics" )

	if (  !IsValid( ent ) ) then return end

	ent:SetModel( model_file )

	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 16 ) )
	ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()

	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end

	local velocity = self.Owner:GetAimVector()
	velocity = velocity * 1000000000
	velocity = velocity + ( VectorRand() * 100 ) -- a random element
	phys:ApplyForceCenter( velocity )

	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "your cumstain" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end

function SWEP:ThrowMelon( model_file )

	self:EmitSound( ShootSound )

	if ( CLIENT ) then return end

	local ent = ents.Create( "prop_physics" )

	if (  !IsValid( ent ) ) then return end

	ent:SetModel( model_file )
 
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 16 ) )
	ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()

	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end

	local velocity = self.Owner:GetAimVector()
	velocity = velocity * 10000000000000000000000
	velocity = velocity + ( VectorRand() * 100 ) -- a random element
	phys:ApplyForceCenter( velocity )

	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "Thrown Melon" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end