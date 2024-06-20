local sub_interfaces = {
    require("aurcore.define.core.class").class_instance_interface,
    require("aurcore.define.core.class").class_manager_interface,
    require("aurcore.define.core.ac_core.utils")
}
---@class Core:ClassManager,Class,CoreUtils
local t = {}

for _, value in pairs(sub_interfaces) do
    for name, i in pairs(value) do
        t[name] = i
    end
end

return t