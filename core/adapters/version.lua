local version = require("aurcore.lib.version.main")

local t = {}

function t:convert2version(versionStr)
    return version(versionStr)
end

function t:convert2strict_version(versionStr)
    return version.strict(versionStr)
end

function t:range(v1, v2)
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

return t