local sub_interfaces = {
    require("aurcore.define.core.wrapper.other")
}
---@class Wrapper:WrapperOther
local t = {}

for _, value in pairs(sub_interfaces) do
    for name, i in pairs(value) do
        t[name] = i
    end
end

return t