local ColorLib = require("aurcore.lib.ansicolors.main")

local color = {_name_ = "colorAdapter"}

function color:get_chart(char, fg)
    return ColorLib.chart(char, fg)
end

function color:is_valid_string_key(key)
    key = tostring(key)
    local t = ColorLib.colorNames
    for name, _ in pairs(t) do
        if key == name or key == string.upper(name) then
            return true
        end
    end
    return false
end

function color:get_fg_color(key)
    return ColorLib.fg[key] or ColorLib.fg(key)
end

function color:get_bg_color(key)
    return ColorLib.bg[key] or ColorLib.bg(key)
end

function color:get_reset_color()
    return ColorLib.reset
end

function color:get_bold_color()
    return ColorLib.bold
end

return color