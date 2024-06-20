local adapter_checker = require("aurcore.core.init"):get_adapter_checker()
local t = {}

function t:get_version_adapter()
    local version_lib = adapter_checker:new("version_lib", require("aurcore.modules.version.main"),
        require("aurcore.define.modules.version.interfaces").version_checker_interface)
    adapter_checker:new("version_lib", version_lib:get_adapter():range("1.0", "2.0"),
        require("aurcore.define.modules.version.interfaces").version_range):get_adapter()
    return version_lib
end

return t
