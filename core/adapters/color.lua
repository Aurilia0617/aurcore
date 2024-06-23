local ansicolor = require("aurcore.lib.color")
local hub = require("aurcore.core.hub")
local i18n = hub:get_i18n()
---@class ColorAdapter
local adapter = hub:new_mixin("ColorAdapter")

function adapter:print_color_chart(char, fg)
    assert(type(char) == "string" or char == nil, i18n.error_msg.incorrect_type_string(type(char)))
    assert(type(fg) == "string" or fg == nil, i18n.error_msg.incorrect_type_string(type(fg)))
    print(ansicolor.chart(char, fg))
end

function adapter:is_valid_color_key(key)
    key = tostring(key)
    local colorNames = ansicolor.colorNames
    for name in pairs(colorNames) do
        if key == name or key == string.upper(name) then
            return true
        end
    end
    return false
end

function adapter:get_fg_color(key)
    assert(key ~= nil, i18n.error_msg.invalid_parameter)
    if type(key) == "number" then
        assert(key >= 0 and key <= 255, i18n.error_msg.invalid_range(0, 255))
        key = tostring(key)
    end
    assert(type(key) == "string", i18n.error_msg.invalid_type_for_color)
    assert(self:is_valid_color_key(key) or type(tonumber(key, 16)) == "number", i18n.error_msg.key_not_exist(key))
    return ansicolor.fg[key] or ansicolor.fg(key)
end

function adapter:get_bg_color(key)
    assert(key ~= nil, i18n.error_msg.invalid_parameter)
    if type(key) == "number" then
        assert(key >= 0 and key <= 255, i18n.error_msg.invalid_range(0, 255))
        key = tostring(key)
    end
    assert(type(key) == "string", i18n.error_msg.invalid_type_for_color)
    assert(self:is_valid_color_key(key) or type(tonumber(key, 16)) == "number", i18n.error_msg.key_not_exist(key))
    return ansicolor.bg[key] or ansicolor.bg(key)
end

function adapter:get_color(tag)
    assert(ansicolor[tag] and type(ansicolor[tag]) == "string", i18n.error_msg.key_not_exist(tag))
    return ansicolor[tag]
end

return adapter
