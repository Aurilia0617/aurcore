local ColorLib = require("aurcore.lib.ansicolors.main")
local i18n = require("aurcore.hub"):get_i18n()

local ColorAdapter = {_name_ = "ColorAdapter"}

--- 获取字符的颜色图表
--- @param char string 字符
--- @param fg string 前景色
--- @return string 返回带颜色的字符图表
function ColorAdapter:get_chart(char, fg)
    return ColorLib.chart(char, fg)
end

--- 检查字符串键是否合法
--- @param key string 待检查的键
--- @return boolean 返回键是否合法
function ColorAdapter:is_valid_string_key(key)
    key = tostring(key)
    local colorNames = ColorLib.colorNames
    for name in pairs(colorNames) do
        if key == name or key == string.upper(name) then
            return true
        end
    end
    return false
end

--- 获取前景色
--- @param key string|number 颜色键
--- @return string 返回前景色
function ColorAdapter:get_fg_color(key)
    assert(key ~= nil, i18n:error_msg("invalid_parameter"))
    if type(key) == "number" then
        assert(key >= 0 and key <= 255, i18n:error_msg("invalid_range", 0, 255))
        key = tostring(key)
    end
    assert(type(key) == "string", i18n:error_msg("invalid_type_for_color"))
    assert(self:is_valid_string_key(key) or type(tonumber(key, 16)) == "number", i18n:error_msg("key_not_exist", key))
    return ColorLib.fg[key] or ColorLib.fg(key)
end

--- 获取背景色
--- @param key string|number 颜色键
--- @return string 返回背景色
function ColorAdapter:get_bg_color(key)
    assert(key ~= nil, i18n:error_msg("invalid_parameter"))
    if type(key) == "number" then
        assert(key >= 0 and key <= 255, i18n:error_msg("invalid_range", 0, 255))
        key = tostring(key)
    end
    assert(type(key) == "string", i18n:error_msg("invalid_type_for_color"))
    assert(self:is_valid_string_key(key) or type(tonumber(key, 16)) == "number", i18n:error_msg("key_not_exist", key))
    return ColorLib.bg[key] or ColorLib.bg(key)
end

--- 获取重置颜色
--- @return string 返回重置颜色
function ColorAdapter:get_reset_color()
    return ColorLib.reset
end

--- 获取粗体颜色
--- @return string 返回粗体颜色
function ColorAdapter:get_bold_color()
    return ColorLib.bold
end

--- 获取指定标签的颜色
--- @param tag string 颜色标签
--- @return string 返回颜色
function ColorAdapter:get_color(tag)
    assert(ColorLib[tag] and type(ColorLib[tag]) == "string", i18n:error_msg("key_not_exist", tag))
    return ColorLib[tag]
end

return ColorAdapter
