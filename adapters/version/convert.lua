local version = require("aurcore.lib.version.main")
local version_check = require("aurcore.adapters.version.version")
local hub = require("aurcore.hub")
local i18n = hub:get_i18n()

local adapter = {}

function adapter:convert2version(versionStr)
    return version(versionStr)
end

function adapter:strict_check_version(versionStr)
    return version.strict(versionStr)
end

function adapter:range(v1, v2)
    local new_range = version.set(v1, v2)
    if new_range then
        function new_range:add(...)
            return new_range:allowed(...)
        end
        function new_range:del(...)
            return new_range:disallowed(...)
        end
    end
    return new_range
end

function adapter:check_version(version_str)
    assert(version_check(self, version_str), i18n:error_msg("incorrect_version", version_str, hub:get_config().version))
end

return adapter