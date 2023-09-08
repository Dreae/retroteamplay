do
	local maps = file.Find( "maps/*.bsp", "GAME" )
	for _, map in ipairs(maps) do
		local thumb_exts = {
			"jpg",
			"jpeg",
			"png"
		}
		local map_name = map:sub( 1, -5 ):lower()
		local thumb = "asset://garrysmod/rtp_revival/nothumb.png"
		for _, ext in ipairs(thumb_exts) do
			if file.Exists("maps/"..map_name.."."..ext, "GAME") then
				thumb = "asset://garrysmod/maps/"..map_name.."."..ext
				break
			elseif file.Exists("maps/thumb/"..map_name.."."..ext, "GAME") then
				thumb = "asset://garrysmod/maps/thumb/"..map_name.."."..ext
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
