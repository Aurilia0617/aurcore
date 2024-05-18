local Hub = require("aurcore.hub")
local color = Hub:get_color()
return {
    headers = { -- 标签样式
        fatal = color:get_bold_color()..color:get_bg_color(1).." FATAL "..color:get_reset_color(),
        error = color:get_bold_color()..color:get_bg_color("C4").." ERRO "..color:get_reset_color(),
        warn = color:get_bold_color()..color:get_bg_color("DC").." WARN "..color:get_reset_color(),
        succ = color:get_bold_color()..color:get_bg_color("4C").." SUCC "..color:get_reset_color(),
        info = color:get_bold_color()..color:get_bg_color("4B").." INFO "..color:get_reset_color(),
        debug = color:get_bold_color()..color:get_bg_color("D").." DBUG "..color:get_reset_color()
    },
    body = { -- 字体样式
        fatal = color:get_reset_color()..color:get_fg_color("C4").."%s"..color:get_reset_color(),
        error = color:get_reset_color().."%s"..color:get_reset_color(),
        warn = color:get_reset_color().."%s"..color:get_reset_color(),
        succ = color:get_reset_color().."%s"..color:get_reset_color(),
        info = color:get_reset_color().."%s"..color:get_reset_color(),
        debug = color:get_reset_color().."%s"..color:get_reset_color(),
        debugInfo = color:get_reset_color()..color:get_fg_color(8).."%s"..color:get_reset_color(),
    },
    default_log_level = Hub:get_config().default_log_level, --当前日志机日志等级
}