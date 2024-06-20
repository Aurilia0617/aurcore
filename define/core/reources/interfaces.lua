local sub_interfaces = {
    require("aurcore.define.core.reources.other")
}
---@class Resources:ResourcesOther
local t = {}

for _, value in pairs(sub_interfaces) do
    for name, i in pairs(value) do
        t[name] = i
    end
end

return t