--- @class Color
local ColorInterface = {}
-- 打印颜色图表
function ColorInterface:get_chart() end
-- 参数是否存在于快捷键中
function ColorInterface:is_valid_string_key(key) end
-- 获得对应前景色
function ColorInterface:get_fg_color(key) end
-- 获得对应背景色
function ColorInterface:get_bg_color(key) end
-- 获得重置
function ColorInterface:get_reset_color() end
-- 获得加粗
function ColorInterface:get_bold_color() end

function ColorInterface:get_color(tag) end
return ColorInterface