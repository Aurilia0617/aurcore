local hub = require("aurcore.core.hub")
local t = hub:new_mixin("resource_methods")

function t:new_ac()
    -- 暴露给wrapper
    return hub:get_adapter("wrapper", hub:new_container({
        self,
        hub:get_adapter("hub_w", hub),
        hub:get_adapter("color"),    -- color模块
        hub:_get_adapter("logger", "logger_ac", self) -- Aur-Core日志机实例
    }))
end

function t:test()
    require("aurcore.core.test.init")(self)
    hub:get_adapter("test"):run()
end

function t:new_logger(...)
    return hub:get_adapter("logger", self):new(self, ...)
end

return t
