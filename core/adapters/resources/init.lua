local hub = require("aurcore.core.hub")
--- @class ResourcesClass:Class
local resources_class = hub:new_class("resources_class")

resources_class:mixin(
    require("aurcore.core.adapters.resources.methods"),
    require("aurcore.core.adapters.resources.triggers.init")
)

resources_class:on_init(function(instance, framework, framework_init)
    function instance:get_framework()
        return framework
    end
    instance.class:include({
        __index = framework
    })
    local t = framework_init(instance)
    instance.class:include({
        __index = t
    })
end)

return resources_class