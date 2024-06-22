local sub_interfaces = {
    require("aurcore.define.core.resources.main"),
    require("aurcore.define.core.resources.expose")
}
---@class Resources:ResourceMain, ResourceExpose
local t = {}

for _, value in pairs(sub_interfaces) do
    for name, i in pairs(value) do
        if t[name] == nil then
            t[name] = i
        end
    end
end

return t