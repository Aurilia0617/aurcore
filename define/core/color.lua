--- @class Color
local ColorInterface = {}
--- 打印字符的颜色图表
--- @param char string 字符
--- @param fg string 前景色
function ColorInterface:print_color_chart(char, fg) end
--- 检查字符串键是否合法
--- @param key string 待检查的键
--- @return boolean 返回键是否合法
function ColorInterface:is_valid_color_key(key) return true end
--- 获取前景色
--- @param key string|number 颜色键
--- @return string 返回前景色
function ColorInterface:get_fg_color(key) return "" end
--- 获取背景色
--- @param key string|number 颜色键
--- @return string 返回背景色
function ColorInterface:get_bg_color(key) return "" end
--- 获取指定标签的颜色
--- @param tag string 颜色标签
--- @return string 返回颜色
function ColorInterface:get_color(tag) return "" end

return ColorInterface