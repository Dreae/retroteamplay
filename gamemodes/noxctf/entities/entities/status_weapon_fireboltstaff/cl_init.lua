include("shared.lua")

function ENT:StatusInitialize()
	self:SetModel("models/morrowind/daedric/staff/w_daedric_staff.mdl")
	self:SetRenderMode(RENDERMODE_TRANSALPHA)
	self:SetRenderBounds(Vector(-60, -60, -32), Vector(60, 60, 100))
	self.Emitter = ParticleEmitter(self:GetPos())
	self.Emitter:SetNearClip(35, 45)
end

function ENT:StatusThink(owner)
	self.Emitter:SetPos(self:GetPos() + self:OBBMaxs().z * 2 * self:GetUp())
end

local matGlow = Material("sprites/light_glow02_add")
function ENT:DrawTranslucent()
	local owner = self:GetOwner()
	if not owner:IsValid() then return end

	local rag = owner:GetRagdollEntity()
	if rag:IsValid() then
		owner = rag
	elseif not owner:Alive() or owner:IsInvisible() then return end

	local angpos = owner:GetAttachment(owner:LookupAttachment("anim_attachment_RH"))

	if angpos then
		self:SetAngles(angpos.Ang)
		self:SetPos(angpos.Pos + self:GetUp() * -6)
		self:DrawModel()
	end

	local pos = self:GetPos() + self:OBBMaxs().z * self:GetUp()
	render.SetMaterial(matGlow)
	render.DrawSprite(pos, 32, 32, COLOR_ORANGE)
	render.DrawSprite(pos, 32, 32, COLOR_RED)

	if EFFECT_QUALITY < 2 then return end

	local emitter = self.Emitter
	for i=1, 2 do
		local particle = emitter:Add("sprites/light_glow02_add", pos + VectorRand() * 6)
		particle:SetVelocity(VectorRand() * 12)
		particle:SetDieTime(math.Rand(0.3, 0.5))
		particle:SetStartAlpha(230)
		particle:SetEndAlpha(50)
		particle:SetStartSize(math.random(8, 10))
		particle:SetEndSize(1)
		particle:SetRoll(math.Rand(-0.8, 0.8))
		particle:SetColor(255, 180, 30)
		particle:SetAirResistance(10)
	end
end
