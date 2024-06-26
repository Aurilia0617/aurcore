local sub_interfaces = {
    require("aurcore.define.core.hub.main"),
    require("aurcore.define.core.hub.expose_c"),
    require("aurcore.define.core.hub.expose_r"),
    require("aurcore.define.core.hub.expose_w"),
}
---@class Hub:HubMain, HubExposeC, HubExposeR, HubExposeW
local t = {}

for _, value in pairs(sub_interfaces) do
    for name, i in pairs(value) do
        if t[name] == nil then
            t[name] = i
        end
    end
end

return t