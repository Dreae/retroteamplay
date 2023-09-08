function AddMap(mapinfo)
    table.insert(GAMEMODE.MapList, util.JSONToTable(mapinfo))
end