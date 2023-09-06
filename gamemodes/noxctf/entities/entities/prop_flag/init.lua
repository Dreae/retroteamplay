// Source Forts compatability
ENT.Type = "point"

function ENT:Initialize()
	self:Fire("kill", "", 15)
end

function ENT:KeyValue(key, value)
	if string.lower(key) == "teamnum" then
		team.SetFlagPoint(value, self:GetPos())
	end
end
