local hub = require("aurcore.core.hub")
local t = hub:new_mixin("resource_methods")
local version_parse = require("aurcore.core.utils.version_parse")
local i18n = hub:get_i18n()

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

function t:check_version(version_str)
    local function throw_error()
        error(i18n.error_msg.incorrect_version(version_str, hub:get_config().version))
    end
    -- 解析版本信息
    local target_version_info = version_parse(version_str)
    local current_version_info = version_parse(hub:get_config().version)

    if target_version_info.build == current_version_info.build and
        target_version_info.type == current_version_info.type and
        target_version_info.version == current_version_info.version then
        return
    end

    -- 版本类型权重
    local type_weights = { Alpha = 1, Beta = 2, Release = 3 }

    -- 将版本信息转换为权重
    local function get_version_weight(version_info)
        return {
            version = self:convert2version(version_info.version),
            type = type_weights[version_info.type] or 0,
            build = self:convert2version(version_info.build)
        }
    end

    local target_weight = get_version_weight(target_version_info)
    local current_weight = get_version_weight(current_version_info)

    -- 比较版本信息，高版本不兼容
    if target_weight.version < current_weight.version or
        (target_weight.version == current_weight.version and target_weight.type < current_weight.type) or
        (target_weight.version == current_weight.version and target_weight.type == current_weight.type and target_weight.build < current_weight.build) then
        throw_error()
    end

    -- v0.1.0-Alpha.10及其往下的较原始版本均不兼容其他版本
    local version5 = get_version_weight(version_parse("v0.1.0-Alpha.10"))
    if target_weight.version >= version5.version and target_weight.type == version5.type and target_weight.build >= version5.build then
        throw_error()
    end
end

return t
