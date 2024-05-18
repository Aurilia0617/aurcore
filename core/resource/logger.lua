local resource = require("aurcore.core.resource.init")

function resource:set_logger_lib(loggerLib)
    function resource:get_new_logger(name)
        return loggerLib:new(resource, name)
    end
    local plugin_name = resource:get_plugin_name()
    resource._logger = loggerLib:new(resource,plugin_name)
    resource._logger:set_debug_stack_depth(3)
    function resource:set_resource_logger()
        return resource._logger
    end
    return resource
end

return resource