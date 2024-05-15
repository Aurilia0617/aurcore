local Color = require("aurcore.core.utils.color.ansicolors")
local Types = require("aurcore.types.init")
local color = Types:new_obj("color")

function color:get_chart_str(...)
    return Color.chart(...)
end

function color:get_fg_str(...)
    return Color.fg(...)
end

function color:get_bg_str(...)
    return Color.bg(...)
end

function color:get_bg_table()
    return Color.bg
end

function color:get_fg_table()
    return Color.fg
end

return color