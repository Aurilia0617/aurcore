local sub_interfaces = {
    require("aurcore.define.core.class").class_manager_interface,
    require("aurcore.define.core.hub.utils"),
    require("aurcore.define.core.hub.other"),
}
---@class Hub:ClassManager, HubOther, HubUtils
local t = {}

for _, value in pairs(sub_interfaces) do
    for name, i in pairs(value) do
        t[name] = i
    end
end

return t