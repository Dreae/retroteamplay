AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

local rockmodels = {
	"models/props_wasteland/rockcliff01b.mdl",
	"models/props_wasteland/rockcliff01c.mdl",
	"models/props_wasteland/rockcliff01e.mdl",
	"models/props_wasteland/rockcliff01g.mdl"
}

ENT.NextSound = 0
ENT.Sappers = 0
ENT.LastThink = 0
ENT.MaxDistance = 200
ENT.MinDistance = 45

function ENT:Initialize()
	self:SetModel(rockmodels[math.random(1, #rockmodels)])
	self:SetPos(self:GetPos() + Vector(0, 0, 8))
	self:PhysicsInitBox(Vector(-14, -14, -48), Vector(14, 14, 48))
	self:SetCollisionBounds(Vector(-14, -14, -48), Vector(14, 14, 48))

	self:SetUseType( CONTINUOUS_USE )
	
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:SetMaterial("metal")
		phys:EnableMotion(false)
		phys:Sleep()
	end

	if self:GetMaxMana() == 0 then
		self:SetMaxMana(self.MaxMana)
	end
	self:SetMana(self:GetMaxMana())
	self.LastThink = CurTime()
end

-- May not be needed
function ENT:Team()
	return 0
end

function ENT:UniqueID()
	return self:EntIndex()
end

function ENT:Alive()
	return self:GetMana() > 0
end
---

function ENT:Think()
	if not self:CanDrain() then return end

	local ents = ents.FindInSphere(self:GetPos(), self.MaxDistance)
	for _, ent in ipairs(ents) do
		if ent:IsPlayer() and 1 <= self:GetMana() and 0 < ent:GetManaRegeneration() then 
			local distance = ent:GetPos():Distance(self:GetPos())
			if distance <= self.MaxDistance then
				self:TransferMana(ent, distance)
			end
		end
	end
	self.LastThink = CurTime()
end

function ENT:TransferMana(player, distance)
	if 1 <= self:GetMana() and 0 < player:GetManaRegeneration() then
		local amount = self.DrainPerSecond * (1 - math.pow(math.max(distance - self.MinDistance, 0) / self.MaxDistance, 0.33))
		amount = math.min(self:GetMana(), (CurTime() - self.LastThink) * amount)

		local wep = player:GetActiveWeapon()
		if wep:IsValid() and wep.MaxMana and player:GetAmmoCount(wep.ChargeAmmo) < wep.MaxMana then
			player:GiveAmmo(amount, wep.ChargeAmmo, true)
			self:SetMana(self:GetMana() - (amount * 0.5))

			self:PlayDrainSound()
		end

		if player:GetMana() < player:GetMaxMana() then
			amount = player:GetStatus("manasickness") and ( amount * 0.3333 ) or amount
			print("Gave "..amount.." mana to "..player:GetName())

			player:SetMana(math.min(player:GetMana() + amount, player:GetMaxMana()), true)
			self:SetMana(self:GetMana() - amount)

			self:PlayDrainSound()
		end
	end
end

function ENT:CanDrain()
	return self:GetMana() > self.NoDrainThreshold
end

function ENT:PlayDrainSound()
	if CurTime() >= self.NextSound then
		self.NextSound = CurTime() + 1.25
		self:EmitSound("nox/managain.ogg")
	end
end
