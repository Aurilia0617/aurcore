local version_parse = require("aurcore.utils.version.parse")
local hub = require("aurcore.hub")
local versionChecker = hub:get_version_checker()

local version = {_name_ = "versionModule"}

function version:version_check(versionStr)
    local info = version_parse(versionStr)
    info.version = versionChecker:convert2version(info.version)
    return info
end

return version