local nox_teams = {}

function team.GetFlagPoint(index)
	if nox_teams[index] ~= nil then
		return nox_teams[index].FlagPoint
	end
	return nil
end

function team.SetFlagPoint(index, point)
	if nox_teams[index] ~= nil then
		nox_teams[index].FlagPoint = point
	else
		nox_teams[index] = {
			FlagPoint = point
		}
	end
end

function team.GetFlag(index)
	if nox_teams[index] ~= nil then
		return nox_teams[index].Flag
	end
	return nil
end

function team.SetFlag(index, flag)
	if nox_teams[index] ~= nil then
		nox_teams[index].Flag = flag
	else
		nox_teams[index] = {
			Flag = flag
		}
	end
end

function team.GetRealScore(index)
	if nox_teams[index] ~= nil then
		return nox_teams[index].RealScore
	end
	return 0
end

function team.SetRealScore(index, score)
	if nox_teams[index] ~= nil then
		nox_teams[index].RealScore = score
	else
		nox_teams[index] = {
			RealScore = score
		}
	end
end

function team.GetLastMinute(index)
	if nox_teams[index] ~= nil then
		return nox_teams[index].LastMinute
	end
	return 0
end

function team.SetLastMinute(index, time)
	if nox_teams[index] ~= nil then
		nox_teams[index].LastMinute = time
	else
		nox_teams[index] = {
			LastMinute = time
		}
	end
end

function team.GetProps(index)
	if index then
		return GetGlobalInt(index.."Pro", 0)
	end

	return 0
end

function team.SetProps(index, props)
	if index then
		SetGlobalInt(index.."Pro", props)
	end
end

function team.AddProps(index, props)
	if index then
		team.SetProps(index, team.GetProps(index) + props)
	end
end

function team.GetMana(index)
	return GetGlobalInt(index.."Mana", 0)
end

function team.SetMana(index, mana)
	SetGlobalInt(index.."Mana", mana)
end

function team.GetMaxMana(index)
	return GetGlobalInt(index.."MaxMana", 1000)
end

function team.SetMaxMana(index, mana)
	SetGlobalInt(index.."MaxMana", mana)
end

function team.GetManaRate(index)
	return GetGlobalInt(index.."MRate", 0)
end

function team.SetManaRate(index, rate)
	SetGlobalInt(index.."MRate", rate)
end

function team.TotalValue(index)
	local value = 0
	for _, pl in pairs(team.GetPlayers(index)) do
		value = value + pl:TeamValue()
	end
	return value
end
