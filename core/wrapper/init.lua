local hub = require("aurcore.core.hub")
local i18n = hub:get_i18n()
--- @class WrapperClass:Class
local wrapper_class = hub:new_class("wrapper_class")

wrapper_class:on_init(function (instance, resources)
    function instance:get_resources()
        return resources
    end
    instance.class:include({
        __index = resources
    })
end)

function wrapper_class:get_resources()
    error(i18n.error_msg.not_initialized("resources"))
end

return wrapper_class