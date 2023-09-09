net.Receive("RTP_MapList", function()
    local json = net.ReadString()
    GAMEMODE.MapList = util.JSONToTable(json)
end)