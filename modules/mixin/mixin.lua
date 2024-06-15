local hub = require("aurcore.hub")
return function(resource)
    resource.class:include(
        hub:get_color(),
        hub:get_logger(resource, resource:get_plugin_name()),
        hub:get_version_checker()
    )
    resource.class._name_ = "Resource" -- 覆盖可能存在的混入通用标识
end
