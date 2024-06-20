local adapter_checker = require("aurcore.core.utils.adapter_checker")
local new_container_fun = require("aurcore.core.utils.container").new_container
local config = require("aurcore.config")
local interfaces = require("aurcore.core.interfaces")

--- @class HubClass:Class
local Hub = interfaces:get_class_adapter():new_class("Hub")

function Hub:new_class(...)
    return interfaces:get_class_adapter():new_class(...)
end

function Hub:new_mixin(...)
    return interfaces:get_class_adapter():new_mixin(...)
end

function Hub:get_i18n()
    return interfaces:get_i18n_adapter(config)
end

function Hub:get_core()
    return interfaces:get_ac_core_adapter()
end

function Hub:new_container(...)
    return new_container_fun(...)
end

function Hub:get_config()
    return config
end

function Hub:is_windows()
    return package.config:sub(1, 1) == '\\'
end

function Hub:is_unix()
    return package.config:sub(1, 1) == '/'
end

function Hub:get_test()
    return interfaces:get_test_adapter()
end

function Hub:get_color()
    return interfaces:get_color_adapter()
end

function Hub:get_adapter_checker()
    return adapter_checker
end

--- @type Hub
local hub = adapter_checker:new("hub", Hub:new(), require("aurcore.define.core.hub.interfaces")):get_adapter()
return hub