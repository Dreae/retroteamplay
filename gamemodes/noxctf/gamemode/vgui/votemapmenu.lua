local PANEL = {}

function PANEL:Init()
    self:SetSize(800, 600)
    self:Center()
    self:SetTitle("MapVote")

    local list = vgui.Create("DListView", self)
    list:Dock(LEFT)
    list:SetMultiSelect(false)
    list:AddColumn("Map")
    list:SetWide(160)

    local vote_info = vgui.Create("DPanel", self)
    vote_info:Dock(RIGHT)
    vote_info:SetSize(600, 600)

    local client_info = vgui.Create("DPanel", vote_info)
    client_info:Dock(LEFT)
    client_info:SetSize(300, 0)

    local map_img = vgui.Create("DImage", client_info)
    map_img:SetSize(160, 120)
    map_img:AlignTop(12)
    map_img:CenterHorizontal()
    local map_label = vgui.Create("DLabel", client_info)
    map_label:AlignTop(134)
    map_label:CenterHorizontal()
    map_label:SetColor(Color(24, 24, 24, 255))
    map_label:SetText("")

    local server_info = vgui.Create("DPanel", vote_info)
    server_info:Dock(RIGHT)
    server_info:SetSize(300, 0)
    
    for _, maptab in ipairs(GAMEMODE.MapList) do
        list:AddLine(maptab.name)
    end

    function list:OnRowSelected(idx, panel)
        map_label:SetText(GAMEMODE.MapList[idx].name)
        map_label:SizeToContents()
        map_label:CenterHorizontal()

        map_img:SetMaterial(Material(GAMEMODE.MapList[idx].thumb))

        RunConsoleCommand("votemap_vote", GAMEMODE.MapList[idx].name)
        surface.PlaySound("buttons/button3.wav")
    end
end

function PANEL:NewVote(ply, map)
    if not ply:IsValid() or not ply:IsPlayer() then return false end
    if ply:SteamID64() ~= LocalPlayer():SteamID64() then
        chat.PlaySound()
    end
end

vgui.Register("RTPVoteMapMenu", PANEL, "DFrame")