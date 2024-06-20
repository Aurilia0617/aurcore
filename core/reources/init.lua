local hub = require("aurcore.core.hub")
local i18n = hub:get_i18n()
local interfaces = require("aurcore.core.interfaces")
--- @class ResourcesClass:Class,ResourcesUtils
local resources_class = hub:new_class("resources_class")

resources_class:mixin(
    require("aurcore.core.reources.utils")
)

resources_class:on_init(function(instance, framework)
    function instance:get_framework()
        return framework
    end
    instance.class:include({
        __index = framework
    })
end)

function resources_class:get_framework()
    error(i18n.error_msg.not_initialized("framework"))
end

function resources_class:new_ac()
    return interfaces:get_wrapper_adapter(interfaces:get_resources_adapter(self))
end

return resources_class
