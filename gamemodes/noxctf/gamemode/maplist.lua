util.AddNetworkString("RTP_MapList")
function SendMapList(pl)
	net.Start("RTP_MapList")
		net.WriteString(util.TableToJSON(GAMEMODE.MapList))
	net.Send(pl)
end

do
	local maps = file.Find( "maps/*.bsp", "GAME" )
	for _, map in ipairs(maps) do
		local thumb_exts = {
			"jpg",
			"jpeg",
			"png"
		}
		local map_name = map:sub( 1, -5 ):lower()
		local thumb = "vgui/avatar_default.vmt"
		for _, ext in ipairs(thumb_exts) do
			if file.Exists("maps/"..map_name.."."..ext, "GAME") then
				thumb = "maps/"..map_name.."."..ext
				break
			elseif file.Exists("maps/thumb/"..map_name.."."..ext, "GAME") then
				thumb = "maps/thumb/"..map_name.."."..ext
				break
			end
		end

		table.insert(GM.MapList, {name = map_name, thumb = thumb})
	end
	table.sort(GM.MapList, function (a, b) 
		return a.name < b.name
	end)
end

collectgarbage("collect")
