local Hub = require("aurcore.hub")
local color = Hub:get_color()
return {
    headers = { -- 标签样式
        color:get_bold_color()..color:get_fg_color(1).." FATAL "..color:get_reset_color(),
        color:get_bold_color()..color:get_fg_color("C4").." ERRO "..color:get_reset_color(),
        color:get_bold_color()..color:get_fg_color("E2").." WARN "..color:get_reset_color(),
        color:get_bold_color()..color:get_fg_color("52").." SUCC "..color:get_reset_color(),
        color:get_bold_color()..color:get_fg_color("57").." INFO "..color:get_reset_color(),
        color:get_bold_color()..color:get_fg_color("D").." DBUG "..color:get_reset_color()
    },
    body = { -- 字体样式
        color:get_reset_color()..color:get_reset_color(),
        color:get_reset_color()..color:get_reset_color(),
        color:get_reset_color()..color:get_reset_color(),
        color:get_reset_color()..color:get_reset_color(),
        color:get_reset_color()..color:get_reset_color(),
        color:get_reset_color()..color:get_reset_color(),
    },
    default_log_level = Hub:get_config().default_log_level, --当前日志机日志等级
}