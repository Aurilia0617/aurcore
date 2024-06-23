--- @class API:ColorExpose, HubExposeW, ResourceExpose, LoggerExpose
local t = {}

local sub_interfaces = {
    require("aurcore.define.core.hub.expose_w"),
    require("aurcore.define.core.resources.expose"),
    require("aurcore.define.core.color.expose"),
    require("aurcore.define.core.logger.expose")
}

for _, value in pairs(sub_interfaces) do
    for name, i in pairs(value) do
        if t[name] == nil then
            t[name] = i
        end
    end
end

return t