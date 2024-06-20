local sub_interfaces = {
    require("aurcore.define.core.wrapper.other"),
    require("aurcore.define.core.logger").logger_interface,
    require("aurcore.define.modules.version.module")
}
---@class Wrapper:WrapperOther,Logger,VersionUtils
local t = {}

for _, value in pairs(sub_interfaces) do
    for name, i in pairs(value) do
        t[name] = i
    end
end

return t