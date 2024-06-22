local sub_interfaces = {
    require("aurcore.define.core.hub.expose_c")
}
---@class ACCore:HubExposeC
local t = {}

--- @return Resources
function t:new_resources(framework_list)
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