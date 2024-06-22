local hub = require("aurcore.core.hub")
--- @class WrapperClass:Class
local wrapper_class = hub:new_class("wrapper_class")

wrapper_class:mixin(
    require("aurcore.core.adapters.wrapper.other")
)

wrapper_class:on_init(function(instance, resources)
    function instance:get_resources()
        return resources
    end
    instance.class:include({
        __index = resources
    })
end)

return wrapper_class