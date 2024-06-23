local Hub = require("aurcore.core.hub")
local color = Hub:get_adapter("color")
return {
    headers = { -- 标签样式
        fatal = color:get_color("bold")..color:get_bg_color(1).." FATAL "..color:get_color("reset"),
        error = color:get_color("bold")..color:get_bg_color("C4").." ERRO "..color:get_color("reset"),
        warn = color:get_color("bold")..color:get_bg_color("DC").." WARN "..color:get_color("reset"),
        succ = color:get_color("bold")..color:get_bg_color("4C").." SUCC "..color:get_color("reset"),
        info = color:get_color("bold")..color:get_bg_color("4B").." INFO "..color:get_color("reset"),
        debug = color:get_color("bold")..color:get_bg_color("D").." DBUG "..color:get_color("reset")
    },
    body = { -- 字体样式
        fatal = color:get_color("reset")..color:get_fg_color("C4").."%s"..color:get_color("reset"),
        error = color:get_color("reset").."%s"..color:get_color("reset"),
        warn = color:get_color("reset").."%s"..color:get_color("reset"),
        succ = color:get_color("reset").."%s"..color:get_color("reset"),
        info = color:get_color("reset").."%s"..color:get_color("reset"),
        debug = color:get_color("reset").."%s"..color:get_color("reset"),
        debugInfo = color:get_color("reset")..color:get_fg_color(8).."%s"..color:get_color("reset"),
    },
    default_log_level = Hub:get_config().default_log_level, --当前日志机日志等级
}