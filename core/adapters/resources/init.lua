local hub = require("aurcore.core.hub")
--- @class ResourcesClass:Class
local resources_class = hub:new_class("resources_class")

resources_class:mixin(
    require("aurcore.core.adapters.resources.methods")
)

resources_class:on_init(function(instance, framework)
    function instance:get_framework()
        return framework
    end
    instance.class:include({
        __index = framework
    })
end)

return resources_class