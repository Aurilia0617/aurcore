local adapter_manager = require("aurcore.core.utils.adapter.manager")
local do_once = require("aurcore.core.utils.do_once")
--- @class Interfaces
local t = {}
-- 键名为要返回的适配器tag
local do_once_list = {
    class_manager = function ()
        adapter_manager:add({
            tag = "class_manager",
            object = require("aurcore.core.adapters.class.adapter"),
            interface = require("aurcore.define.core.class").class_manager_interface,
            regenerate = false,
            sub_adapter = {
                tag = "class",
                fun = "new_class",
                args = {"test"},
                interface = require("aurcore.define.core.class").class_interface,
                regenerate = false,
                sub_adapter = {
                    tag = "class_instance",
                    fun = "new",
                    interface = require("aurcore.define.core.class").class_instance_interface,
                    regenerate = false,
                }
            }
        })
    end,
    hub = function (object)
        adapter_manager:add({
            tag = "hub",
            object = object,
            interface = require("aurcore.define.core.hub.interfaces"),
            regenerate = false,
        })
    end,
    i18n = function (object)
        adapter_manager:add({
            tag = "i18n_class",
            object = require("aurcore.core.adapters.i18n"),
            interface = require("aurcore.define.core.i18n").i18n_class_interface,
            regenerate = false,
            sub_adapter = {
                tag = "i18n",
                fun = "new",
                args = {object},
                interface = require("aurcore.define.core.i18n").i18n_interface,
                regenerate = true
            }
        })
    end,
    ac_core = function ()
        adapter_manager:add({
            tag = "ac_core",
            object = require("aurcore.core.adapters.ac_core.init"),
            interface = require("aurcore.define.core.ac_core"),
            regenerate = false
        })
    end,
    hub_c = function (object)
        adapter_manager:add({
            tag = "hub_c",
            object = object,
            interface = require("aurcore.define.core.hub.expose_c"),
            regenerate = false,
        })
    end,
    hub_r = function (object)
        adapter_manager:add({
            tag = "hub_r",
            object = object,
            interface = require("aurcore.define.core.hub.expose_r"),
            regenerate = false,
        })
    end,
    hub_w = function (object)
        adapter_manager:add({
            tag = "hub_w",
            object = object,
            interface = require("aurcore.define.core.hub.expose_w"),
            regenerate = false,
        })
    end,
    resources = function (object)
        adapter_manager:add({
            tag = "resources_class",
            object = require("aurcore.core.adapters.resources.init"),
            interface = require("aurcore.define.core.class").class_interface,
            regenerate = false,
            sub_adapter = {
                tag = "resources",
                fun = "new",
                args = {object},
                interface = require("aurcore.define.core.resources.interfaces"),
                regenerate = true
            }
        })
    end,
    frameworks = function (object)
        adapter_manager:add({
            tag = "frameworks",
            object = object,
            interface = require("aurcore.define.frameworks"),
            regenerate = true,
        })
    end,
    wrapper = function (object)
        adapter_manager:add({
            tag = "wrapper_class",
            object = require("aurcore.core.adapters.wrapper.init"),
            interface = require("aurcore.define.core.class").class_interface,
            regenerate = false,
            sub_adapter = {
                tag = "wrapper",
                fun = "new",
                args = {object},
                interface = require("aurcore.define.core.wrapper.interfaces"),
                regenerate = true
            }
        })
    end,
    test = function ()
        adapter_manager:add({
            tag = "test",
            object = require("aurcore.core.adapters.test"),
            interface = require("aurcore.define.core.test"),
            regenerate = false
        })
    end,
    color = function ()
        adapter_manager:add({
            tag = "color",
            object = require("aurcore.core.adapters.color"),
            interface = require("aurcore.define.core.color.interfaces"),
            regenerate = false
        })
    end,
    logger = function (object)
        adapter_manager:add({
            tag = "logger",
            object = require("aurcore.core.adapters.logger.init"),
            interface = require("aurcore.define.core.logger.main").logger_manager_interface,
            regenerate = false,
            sub_adapter = {
                tag = "logger_ac",
                fun = "new",
                args = {object, "Aur-Core"},
                interface = require("aurcore.define.core.logger.main").logger_interface,
                regenerate = false
            }
        })
    end,
}
for key, value in pairs(do_once_list) do
    do_once_list[key] = do_once(value)
end

function t:get_adapter(tag, ...)
    do_once_list[tag](...)
    return adapter_manager:get_adapter(tag)
end

function t:_get_adapter(tag, tag2, ...)
    do_once_list[tag](...)
    return adapter_manager:get_adapter(tag2)
end

return t