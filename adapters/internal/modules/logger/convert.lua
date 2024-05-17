local style = require("aurcore.adapters.internal.modules.logger.style")
local Hub = require("aurcore.hub")
local i18n = Hub:get_i18n()
local types = Hub:get_types()

local loggerLib = types:new_obj("loggerLib")

function loggerLib:new(resource ,name)
    local newLogger = types:new_obj("logger")
    function newLogger:get_log_name()
        return name or resource:get_plugin_name()
    end
    function newLogger:set_log_name(newName)
        function newLogger:get_log_name()
            return newName
        end
        return newLogger
    end
    return newLogger
end

return loggerLib