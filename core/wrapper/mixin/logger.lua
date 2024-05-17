local Hub = require("aurcore.hub")
local types = Hub:get_types()
local i18n = Hub:get_i18n()

local loggerMixin = types:new_obj("loggerMixin")

function loggerMixin:get_log_name()
    return self:_get_resource():get_log_name()
end

function loggerMixin:set_log_name(name)
    return self:_get_resource():set_log_name(name)
end


return loggerMixin