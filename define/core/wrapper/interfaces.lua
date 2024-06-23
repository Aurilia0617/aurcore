local sub_interfaces = {
    require("aurcore.define.core.hub.expose_w"),
    require("aurcore.define.core.resources.expose")
}
---@class Wrapper
local t = {}

---@return Resources
function t:get_resources()
    return {}
end

for _, value in pairs(sub_interfaces) do
    for name, i in pairs(value) do
        if t[name] == nil then
            t[name] = i
        end
    end
end

return t