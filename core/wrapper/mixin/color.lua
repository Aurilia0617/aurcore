local Hub = require("aurcore.hub")
local types = Hub:get_types()
local i18n = Hub:get_i18n()

local colorMixin = types:new_obj("colorMixin")

function colorMixin:get_color_chart()
    return self:_get_resource():get_color():get_chart()
end

function colorMixin:get_fg_color(key)
    local color = self:_get_resource():get_color()
    if type(key) == "number" then
        key = tostring(key)
    end
    assert(type(key) == "string", i18n:error("incorrectKeyTypeForColorTable"))
    assert(color:valid_string_key(key) or type(tonumber(key,16)) == "number", i18n:error("keyDoesNotExist",key))
    return color:get_fg_color(key)
end

function colorMixin:get_bg_color(key)
    local color = self:_get_resource():get_color()
    if type(key) == "number" then
        key = tostring(key)
    end
    assert(type(key) == "string", i18n:error("incorrectKeyTypeForColorTable"))
    assert(color:valid_string_key(key) or type(tonumber(key,16)) == "number", i18n:error("keyDoesNotExist",key))
    return color:get_bg_color(key)
end

function colorMixin:get_color(key)
    assert(type(key) == "string", i18n:error("incorrectKeyTypeStringRequired",type(key)))
    if key == "reset" then
        return self:_get_resource():get_color():get_reset_color()
    elseif key == "bold" then
        return self:_get_resource():get_color():get_bold_color()
    end
end

return colorMixin