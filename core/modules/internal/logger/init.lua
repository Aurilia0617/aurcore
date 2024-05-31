local style = require("aurcore.core.modules.internal.logger.style")
local Hub = require("aurcore.hub")
local i18n = Hub:get_i18n()
local default_log_level = Hub:get_config().default_log_level

local loggerModule = {_name_ = "loggerModule"}

function loggerModule:new(resource, name)
    local newLogger = {_name_ = "loggerInstance"}
    function newLogger:get_log_name()
        return name or resource:get_plugin_name()
    end

    function newLogger:set_log_name(newName)
        assert(type(newName) == "string", i18n:error("incorrectKeyTypeStringRequired", type(newName)))
        function newLogger:get_log_name()
            return newName
        end
        return newLogger
    end
    
    local log_level = default_log_level
    function newLogger:get_log_level()
        return log_level
    end

    function newLogger:set_log_level(level)
        assert(type(level) == "number", i18n:error("incorrectKeyTypeNumberRequired", type(level)))
        log_level = level
        return newLogger
    end

    local _debugStackDepth = Hub:get_config().default_debug_stack_depth
    function newLogger:set_debug_stack_depth(num)
        assert(type(num) == "number", i18n:error("incorrectKeyTypeNumberRequired", type(num)))
        _debugStackDepth = num
    end

    function newLogger:get_debug_stack_depth()
        return _debugStackDepth
    end

    function newLogger:fatal(msg, ...)
        msg = string.format(msg or "", ...)
        resource:log_without_print(("FATAL %s"):format(msg))
        resource:print(("%s [%s] %s %s"):format(os.date("!%H:%M:%S", resource:now()), self:get_log_name(),
            style.headers.fatal, (style.body.fatal):format(msg)))
        error(msg)
    end

    function newLogger:error(msg, ...)
        msg = string.format(msg or "", ...)
        resource:log_without_print(("ERROR %s"):format(msg))
        resource:print(("%s [%s] %s %s"):format(os.date("!%H:%M:%S", resource:now()), self:get_log_name(),
            style.headers.error, (style.body.error):format(msg)))
    end

    function newLogger:warn(msg, ...)
        msg = string.format(msg or "", ...)
        resource:log_without_print(("WARN %s"):format(msg))
        resource:print(("%s [%s] %s %s"):format(os.date("!%H:%M:%S", resource:now()), self:get_log_name(),
            style.headers.warn, (style.body.warn):format(msg)))
    end

    function newLogger:info(msg, ...)
        msg = string.format(msg or "", ...)
        resource:print(("%s [%s] %s %s"):format(os.date("!%H:%M:%S", resource:now()), self:get_log_name(),
            style.headers.info, (style.body.info):format(msg)))
    end

    function newLogger:succ(msg, ...)
        msg = string.format(msg or "", ...)
        resource:print(("%s [%s] %s %s"):format(os.date("!%H:%M:%S", resource:now()), self:get_log_name(),
            style.headers.succ, (style.body.succ):format(msg)))
    end

    function newLogger:debug(msg, ...)
        local info = debug.getinfo(newLogger:get_debug_stack_depth(), "nuSl")
        msg = string.format(msg or "", ...)
        resource:print(
            ("%s [%s] %s %s\n\t%s\n\t%s\n\t%s\n\t%s"):format(
                os.date("!%H:%M:%S", resource:now()), self:get_log_name(),
                style.headers.debug, (style.body.debug):format(msg),
                (style.body.debugInfo):format("├── line:" .. info.currentline),
                (style.body.debugInfo):format("├── nups:" .. info.nups),
                (style.body.debugInfo):format(("├── block scope:%s~%s"):format(info.linedefined, info.lastlinedefined)),
                (style.body.debugInfo):format("└── plugin name:" .. resource:get_plugin_name())
            )
        )
    end

    return newLogger
end

return loggerModule
