local adapter_checker = require("aurcore.utils.validators.adapter_checker")
--- @type ClassLib
local class_adapter = adapter_checker:new("class", require("aurcore.class.adapter"),
    require("aurcore.class.interfaces").classLibInterface):get_adapter()
-- 创建并验证类实例适配器是否满足类接口规范
adapter_checker:new("class_instance", require("aurcore.class.adapter"):new_class("test"),
    require("aurcore.class.interfaces").classInterface)

--- @class Hub:Class
local Hub = class_adapter:new_class("Hub")

--- 获取配置模块
--- @return table 返回配置模块
function Hub:get_config()
    return require("aurcore.config")
end

--- 创建一个新的类
--- @param name string 新类的名称
--- @param super table|nil 父类
--- @param config table|nil 类配置
--- @return table 新创建的类
function Hub:new_class(name, super, config)
    return class_adapter:new_class(name, super, config)
end

--- 获取国际化适配器实例
--- @return I18n 国际化适配器实例
function Hub:get_i18n()
    -- 创建并检查i18n类适配器
    adapter_checker:new(
        "i18n",
        require("aurcore.adapters.i18n.convert"),
        require("aurcore.define.utils.i18n.interfaces").i18nClassInterface
    )

    -- 创建并检查i18n实例适配器，并返回适配器
    return adapter_checker:new(
        "i18n_instance",
        require("aurcore.adapters.i18n.convert"):new(self:get_config()),
        require("aurcore.define.utils.i18n.interfaces").i18nInterface
    ):get_adapter()
end

--- 获取单元测试适配器实例
--- @return table @返回单元测试适配器实例
function Hub:get_test()
    return adapter_checker:new(
        "unit_test",
        require("aurcore.adapters.test.convert"),
        require("aurcore.define.lib.test.interfaces")
    ):get_adapter()
end

--- 获取测试运行函数
--- @return function @返回测试运行函数
function Hub:get_run_test(o)
    return require("aurcore.test.init")(o)
end

--- 获取适配器检查器
--- @return table 返回适配器检查器实例
function Hub:get_adapter_checker()
    return adapter_checker
end

--- 创建新的容器实例
--- @param objects_list table 包含对象的列表
--- @return table 返回新的容器实例
function Hub:new_container(objects_list)
    return require("aurcore.utils.table.container").new_container(objects_list)
end

--- 添加模块资源
--- @param resource table 模块资源
--- @return table 返回添加的模块资源结果
function Hub:add_modules(resource)
    return require("aurcore.core.add_module")(resource)
end

--- 创建新的资源实例
--- @param container table 容器实例
--- @return table 返回新的资源实例
function Hub:new_resource(container)
    return require("aurcore.core.resource.init")(container)
end

--- 获取颜色适配器实例
--- @return Color @返回颜色适配器实例
function Hub:get_color()
    return adapter_checker:new(
        "color_utils",
        require("aurcore.adapters.color.convert"),
        require("aurcore.define.lib.color.interfaces")
    ):get_adapter()
end

--- 获取日志适配器实例
--- @param resource table 资源对象
--- @param name string 日志名称
--- @return Logger 返回日志适配器实例
function Hub:get_logger(resource, name)
    -- 检查并初始化 Logger 类适配器
    adapter_checker:new(
        "LoggerClass",
        require("aurcore.modules.mixin.logger.init"),
        require("aurcore.define.modules.logger.interfaces").LoggerLibInterface
    )

    -- 创建并返回指定名称的 Logger 实例适配器
    return adapter_checker:new(
        "logger:" .. name,
        require("aurcore.modules.mixin.logger.init"):new(resource, name),
        require("aurcore.define.modules.logger.interfaces").LoggerInterface
    ):get_adapter()
end

--- 获取版本检查适配器实例
--- @return versionChecker 返回版本检查适配器实例
function Hub:get_version_checker()
    return adapter_checker:new(
        "VersionChecker",
        require("aurcore.adapters.version.convert"),
        require("aurcore.define.lib.version.interfaces")
    ):get_adapter()
end

function Hub:get_table_flattener(resource)
    return adapter_checker:new(
        "TableFlattener",
        require("aurcore.utils.table.flatten_table"),
        require("aurcore.define.utils.flattener.interfaces")
    ):get_adapter():init(function ()
        return resource:uuid()
    end)
end

--- @class Hub
local instance =  Hub:new()
return instance
