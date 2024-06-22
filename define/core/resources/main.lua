local sub_interfaces = {
    require("aurcore.define.core.hub.expose_r"),
}
---@class ResourceMain
local t = {}

--- @return Wrapper
function t:new_ac()
    return {}
end

--- @class Framework:Frameworks,HubExposeR
local t2 = {}

---@return Framework
function t:get_framework()
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