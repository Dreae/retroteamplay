local PANEL = {}

function PANEL:Init()
    self:OpenURL("asset://garrysmod/rtp_revival/votemap.html")
    self:AddFunction("noxctf", "close", function() 
        self:Remove()
    end)
end

function PANEL:OnDocumentReady()
    self:Call("set_maplist("..util.TableToJSON(GAMEMODE.MapList)..")")
end

vgui.Register("RTPVoteMapMenu", PANEL, "DHTML")