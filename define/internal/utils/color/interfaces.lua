local check_method = require("aurcore.define.check")

local ColorInterface = {}

function ColorInterface:get_chart() end

function ColorInterface:valid_string_key() end

function ColorInterface:get_fg_color() end

function ColorInterface:get_bg_color() end

function ColorInterface:get_reset_color() end

function ColorInterface:get_bold_color() end

return function (ColorLib)
    check_method(ColorLib,ColorInterface)
    return ColorLib
end