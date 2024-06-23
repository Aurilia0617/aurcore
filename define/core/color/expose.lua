--- @class ColorExpose
local t = {}
--- 打印字符的颜色图表
--- @param char string|nil 字符
--- @param fg string|nil 前景色
function t:print_color_chart(char, fg) end
--- 获取前景色
--- @param key string|number 颜色键
--- @return string 返回前景色
function t:get_fg_color(key) return "" end
--- 获取背景色
--- @param key string|number 颜色键
--- @return string 返回背景色
function t:get_bg_color(key) return "" end
--- 获取指定标签的颜色
--- @param tag string 颜色标签
--- @return string 返回颜色
function t:get_color(tag) return "" end

return t