local Hub = require("aurcore.hub")
local types = Hub:get_types()
local i18n = Hub:get_i18n()

local loggerMixin = types:new_obj("loggerMixin")

function loggerMixin:get_log_name()
    return self:_get_resource():set_resource_logger():get_log_name()
end

function loggerMixin:set_log_name(name)
    return self:_get_resource():set_resource_logger():set_log_name(name)
end

function loggerMixin:fatal(...)
    return self:_get_resource():set_resource_logger():fatal(...)
end

function loggerMixin:error(...)
    return self:_get_resource():set_resource_logger():error(...)
end

function loggerMixin:warn(...)
    return self:_get_resource():set_resource_logger():warn(...)
end

function loggerMixin:succ(...)
    return self:_get_resource():set_resource_logger():succ(...)
end

function loggerMixin:info(...)
    return self:_get_resource():set_resource_logger():info(...)
end

function loggerMixin:debug(...)
    return self:_get_resource():set_resource_logger():debug(...)
end


return loggerMixin