local style = require("aurcore.core.adapters.logger.style")
local Hub = require("aurcore.core.hub")
local i18n = Hub:get_i18n()
local default_log_level = Hub:get_config().default_log_level

local loggerModule = Hub:new_class("loggerModule")

loggerModule:on_init(function (instance, resource, name)
    function instance:get_log_name()
        return name or resource:get_plugin_name()
    end

    function instance:set_log_name(newName)
        assert(type(newName) == "string", i18n.error_msg.incorrect_type_string(type(newName)))
        function instance:get_log_name()
            return newName
        end

        return instance
    end

    local log_level = default_log_level
    function instance:get_log_level()
        return log_level
    end

    function instance:set_log_level(level)
        assert(type(level) == "number", i18n.error_msg.incorrect_type_number(type(level)))
        log_level = level
        return instance
    end

    local _debugStackDepth = Hub:get_config().default_debug_stack_depth
    function instance:set_debug_stack_depth(num)
        assert(type(num) == "number", i18n.error_msg.incorrect_type_number(type(num)))
        _debugStackDepth = num
    end

    function instance:get_debug_stack_depth()
        return _debugStackDepth
    end

    function instance:fatal(msg, ...)
        msg = string.format(msg or "", ...)
        resource:log_without_print(("FATAL %s"):format(msg))
        resource:print(("%s [%s] %s %s"):format(os.date("!%H:%M:%S", resource:now()), self:get_log_name(),
            style.headers.fatal, (style.body.fatal):format(msg)))
        error(msg)
    end

    function instance:error(msg, ...)
        msg = string.format(msg or "", ...)
        resource:log_without_print(("ERROR %s"):format(msg))
        resource:print(("%s [%s] %s %s"):format(os.date("!%H:%M:%S", resource:now()), self:get_log_name(),
            style.headers.error, (style.body.error):format(msg)))
    end

    function instance:warn(msg, ...)
        msg = string.format(msg or "", ...)
        resource:log_without_print(("WARN %s"):format(msg))
        resource:print(("%s [%s] %s %s"):format(os.date("!%H:%M:%S", resource:now()), self:get_log_name(),
            style.headers.warn, (style.body.warn):format(msg)))
    end

    function instance:info(msg, ...)
        msg = string.format(msg or "", ...)
        resource:print(("%s [%s] %s %s"):format(os.date("!%H:%M:%S", resource:now()), self:get_log_name(),
            style.headers.info, (style.body.info):format(msg)))
    end

    function instance:succ(msg, ...)
        msg = string.format(msg or "", ...)
        resource:print(("%s [%s] %s %s"):format(os.date("!%H:%M:%S", resource:now()), self:get_log_name(),
            style.headers.succ, (style.body.succ):format(msg)))
    end

    function instance:debug(msg, ...)
        local info = debug.getinfo(instance:get_debug_stack_depth(), "nuSl")
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

    return instance
end)

return loggerModule
