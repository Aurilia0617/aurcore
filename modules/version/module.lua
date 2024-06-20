local version_parse = require("aurcore.lib.version.utils")
local core = require("aurcore.core.init")

--- 低版本兼容性验证
---@param adapter table 适配器对象
---@param version_str string 版本字符串
---@return boolean 是否兼容
return function(adapter, version_str)
    -- 解析版本信息
    local target_version_info = version_parse(version_str)
    local current_version_info = version_parse(core:get_config().version)

    if target_version_info.build == current_version_info.build and
        target_version_info.type == current_version_info.type and
        target_version_info.version == current_version_info.version then
        return true
    end

    -- 版本类型权重
    local type_weights = { Alpha = 1, Beta = 2, Release = 3 }

    -- 将版本信息转换为权重
    local function get_version_weight(version_info)
        return {
            version = adapter:convert2version(version_info.version),
            type = type_weights[version_info.type] or 0,
            build = adapter:convert2version(version_info.build)
        }
    end

    local target_weight = get_version_weight(target_version_info)
    local current_weight = get_version_weight(current_version_info)

    -- 比较版本信息，高版本不兼容
    if target_weight.version < current_weight.version or
        (target_weight.version == current_weight.version and target_weight.type < current_weight.type) or
        (target_weight.version == current_weight.version and target_weight.type == current_weight.type and target_weight.build < current_weight.build) then
        return false
    end

    -- v0.1.0-Alpha.5及其往下的较原始版本均不兼容其他版本
    local version5 = get_version_weight(version_parse("v0.1.0-Alpha.5"))
    if target_weight.version >= version5.version and target_weight.type == version5.type and target_weight.build >= version5.build then
        return false
    end

    return true
end
