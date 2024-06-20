local core = require("aurcore.core.init")
local i18n = core:get_i18n()
local version = require("aurcore.lib.version.main")
---@class version_class:Class
local version_module_class = core:new_class("version_module_class")

function version_module_class:convert2version(versionStr)
    return version(versionStr)
end

function version_module_class:strict_check_version(versionStr)
    return version.strict(versionStr)
end

function version_module_class:range(v1, v2)
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

function version_module_class:check_version(version_str)
    assert(require("aurcore.modules.version.module")(self, version_str),
        i18n.error_msg.incorrect_version(version_str, core:get_config().version))
end

return version_module_class
