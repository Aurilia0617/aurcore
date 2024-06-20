local color = {}

-- 转义序列起始部分
local esc = string.char(27, 91)

-- 快捷访问颜色名称列表
color.colorNames = {
    black = 0, red = 1, green = 2, yellow = 3,
    blue = 4, pink = 5, cyan = 6, white = 7
}

color.fg = {}
color.bg = {}

-- 生成颜色转义序列
for name, code in pairs(color.colorNames) do
   color.fg[name] = esc .. tostring(30 + code) .. 'm'
   color.bg[name] = esc .. tostring(40 + code) .. 'm'
end

-- 高亮颜色转义序列
for name, code in pairs(color.colorNames) do
   color.fg[string.upper(name)] = esc .. tostring(90 + code) .. 'm'
   color.bg[string.upper(name)] = esc .. tostring(100 + code) .. 'm'
end

-- 256色前景色和背景色函数
local function color256(fg, n)
   return esc .. (fg and "38;5;" or "48;5;") .. n .. 'm'
end

setmetatable(color.fg, {__call = function(_, n) return color256(true, tonumber(n, 16)) end})
setmetatable(color.bg, {__call = function(_, n) return color256(false, tonumber(n, 16)) end})

-- 定义其他颜色控制转义序列
color.reset = esc .. '0m' -- 重置颜色
color.clear = esc .. '2J' -- 清除屏幕
color.bold = esc .. '1m' -- 加粗
color.faint = esc .. '2m' -- 变淡
color.normal = esc .. '22m' -- 正常
color.invert = esc .. '7m' -- 反显
color.underline = esc .. '4m' -- 下划线
color.hide = esc .. '?25l' -- 隐藏光标
color.show = esc .. '?25h' -- 显示光标

-- 光标移动函数
function color.move(x, y)
   return esc .. y .. ';' .. x .. 'H'
end

-- 快捷方式：移动光标到屏幕左上角
color.home = color.move(1, 1)

function color.chart(char, fg)
   local str = color.reset .. color.bg.WHITE .. (fg or color.fg.BLACK)
   for y = 0, 15 do
      for x = 0, 15 do
         local lbl = string.format("%X", x + y * 16)
         str = str .. color.bg(0) .. color.fg.white .. lbl
         str = str .. color.bg(x + y * 16) .. (fg or '') .. (char or ' ')
      end
      str = str .. color.reset .. "\n"
   end
   return str .. color.reset
end

if package.config:sub(1, 1) == '\\' then
   for name, _ in pairs(color.colorNames) do
      color.fg[name] = ''
      color.bg[name] = ''
   end
end

return color
