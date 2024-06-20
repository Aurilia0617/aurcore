local adapter_checker = require("aurcore.core.utils.adapter_checker")
local t = {}

function t:get_class_adapter()
    local class_manager = adapter_checker:new("class_manager", require("aurcore.core.class.adapter"),
        require("aurcore.define.core.class").class_manager_interface):get_adapter()
    local class_instance = adapter_checker:new("class_instance", class_manager:new_class("test"),
        require("aurcore.define.core.class").class_interface):get_adapter()
    adapter_checker:new("class_instance_instance", class_instance:new(),
        require("aurcore.define.core.class").class_instance_interface):get_adapter()
    return class_manager
end

function t:get_i18n_adapter(config)
    local class = adapter_checker:new("i18n_class", require("aurcore.core.adapters.i18n"),
        require("aurcore.define.core.i18n").i18n_class_interface):get_adapter()
    return adapter_checker:new("i18n", class:new(config),
        require("aurcore.define.core.i18n").i18n_interface, true, true):get_adapter()
end

function t:get_ac_core_adapter()
    return adapter_checker:new("ac_core",
        require("aurcore.core.utils.container").new_container({ require("aurcore.core.adapters.ac_core.init"), require(
        "aurcore.core.hub") }), require("aurcore.define.core.ac_core.interfaces")):get_adapter()
end

function t:get_test_adapter()
    return adapter_checker:new("unit_test", require("aurcore.core.adapters.test"),
        require("aurcore.define.core.test")):get_adapter()
end

function t:get_color_adapter()
    return adapter_checker:new("color", require("aurcore.core.adapters.color"),
        require("aurcore.define.core.color")):get_adapter()
end

function t:get_wrapper_adapter(resource)
    return adapter_checker:new("wrapper", require("aurcore.core.wrapper.init"):new(resource),
        require("aurcore.define.core.wrapper.interfaces")):get_adapter()
end

function t:get_resources_adapter(adapter)
    return adapter_checker:new("resources",adapter,
        require("aurcore.define.core.reources.interfaces")):get_adapter()
end

function t:get_logger_adapter(resource, name)
    local logger_manager = adapter_checker:new("logger_manager", require("aurcore.core.adapters.logger.init"),
        require("aurcore.define.core.logger").logger_manager_interface):get_adapter()
    return adapter_checker:new("logger", logger_manager:new(resource, name),
        require("aurcore.define.core.logger").logger_interface, false, true):get_adapter()
end

return t
