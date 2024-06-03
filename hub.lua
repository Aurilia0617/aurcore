local hub = {_name_ = "Hub"}

function hub:get_config()
    return require("aurcore.config")
end

function hub:get_basic_module()
    return require("aurcore.modle.module_basic")
end

function hub:get_internal_module()
    return require("aurcore.modle.module_internal")
end

--- @return class
--- @param name string
--- @param super class|nil
--- @param ... any
function hub:new_class(name, super, ...)
    return require("aurcore.class.init"):new_class(name, super, ...)
end

local resource_tag
function hub:check_resource(resource)
    local bm = self:get_internal_module()
    if not resource_tag then
        resource_tag = "resource"
        bm:set_define(resource_tag, require("aurcore.define.internal.resource.interfaces"))
        bm:set_adapter(resource_tag, resource)
    end
    bm:replace_adapter(resource_tag, resource)
    return bm:get_adapter(resource_tag)
end

local color_tag
--- @return Color
function hub:get_color()
    local bm = self:get_basic_module()
    if not color_tag then
        color_tag = "color"
        bm:set_define(color_tag, require("aurcore.define.lib.color.interfaces"))
        bm:set_adapter(color_tag, require("aurcore.adapters.lib.color.convert"))
    end
    return bm:get_adapter(color_tag)
end

local i18n_tag
--- @return I18n
function hub:get_i18n()
    local bm = self:get_basic_module()
    if not i18n_tag then
        i18n_tag = "i18n"
        bm:set_define(i18n_tag, require("aurcore.define.lib.i18n.interfaces"))
        bm:set_adapter(i18n_tag, require("aurcore.adapters.lib.i18n.convert"))
    end
    return bm:get_adapter(i18n_tag):new(self:get_config())
end

local logger_tag
--- @return Logger
function hub:get_logger_module(resource, logName)
    local bm = self:get_internal_module()
    if not logger_tag then
        logger_tag = "LoggerModule"
        bm:set_define(logger_tag, require("aurcore.define.internal.modules.logger.interfaces").LoggerLibInterface)
        bm:set_adapter(logger_tag, require("aurcore.core.modules.internal.logger.init"))
        bm:set_define(logger_tag.." test new", require("aurcore.define.internal.modules.logger.interfaces").LoggerInterface)
        bm:set_adapter(logger_tag.." test new", require("aurcore.core.modules.internal.logger.init"):new(self:check_resource(resource), "Test"))
        bm:get_adapter(logger_tag.." test new")
    end
    return bm:get_adapter(logger_tag):new(self:check_resource(resource), logName)
end

-- 先init才能注入模块
function hub:inject(dep)
    return require("aurcore.core.resource.init"):inject(dep)
end

function hub:init(framework)
    return require("aurcore.core.resource.init"):inject({framework = framework})
end

return hub