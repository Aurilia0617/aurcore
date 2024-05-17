local resource = require("aurcore.core.resource.init")

function resource:set_logger_lib(loggerLib)
    function resource:get_new_logger(name)
        return loggerLib:new(resource, name)
    end
    local plugin_name = resource:get_plugin_name()
    resource._logger = loggerLib:new(resource,plugin_name)
    function resource:set_log_name(name)
        return resource._logger:set_log_name(name)
    end
    function resource:get_log_name()
        return resource._logger:get_log_name()
    end
    return resource
end

return resource