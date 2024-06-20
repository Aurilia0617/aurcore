local hub = require("aurcore.core.hub")
local t = hub:new_mixin("core_utils")

function t:new_resources(framework)
    return require("aurcore.core.reources.init"):new(hub:new_container(framework))
end

return t