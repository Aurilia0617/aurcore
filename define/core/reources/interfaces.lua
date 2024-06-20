local sub_interfaces = {
    require("aurcore.define.core.reources.other"),
    require("aurcore.define.modules.version.interfaces").version_checker_interface
}
---@class Resources:ResourcesOther,versionChecker
local t = {}

for _, value in pairs(sub_interfaces) do
    for name, i in pairs(value) do
        t[name] = i
    end
end

return t