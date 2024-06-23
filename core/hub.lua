local adapter_manager = require("aurcore.core.utils.adapter.manager")
local do_once = require("aurcore.core.utils.do_once")
local new_container_fun = require("aurcore.core.utils.container").new_container
local config = require("aurcore.config")
local interfaces = require("aurcore.core.interfaces")
local is_array = require("aurcore.core.utils.type").is_array

--- @class NI_Hub:Class
local t = interfaces:get_adapter("class_manager"):new_class("hub")

function t:new_class(...)
    return interfaces:get_adapter("class_manager"):new_class(...)
end

function t:new_mixin(...)
    return interfaces:get_adapter("class_manager"):new_mixin(...)
end

function t:do_once(...)
    return do_once(...)
end

function t:new_container(...)
    return new_container_fun(...)
end

function t:get_config()
    return config
end

function t:is_array(...)
    return is_array(...)
end

function t:is_windows()
    return package.config:sub(1, 1) == '\\'
end

function t:is_unix()
    return package.config:sub(1, 1) == '/'
end

function t:get_adapter_manager()
    return adapter_manager
end

function t:get_i18n()
    return interfaces:get_adapter("i18n", self:get_config())
end

function t:get_adapter(tag, ...)
    return interfaces:get_adapter(tag, ...)
end

function t:_get_adapter(tag, tag2, ...)
    return interfaces:_get_adapter(tag, tag2, ...)
end

--- @class Hub
local hub = t:get_adapter("hub", t)
return hub