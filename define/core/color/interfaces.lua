-- 注意顺序（重写）
local sub_interfaces = {
    require("aurcore.define.core.color.expose")
}
---@class Color:ColorExpose
local t = {}

--- 检查字符串键是否合法
--- @param key string 待检查的键
--- @return boolean 返回键是否合法
function t:is_valid_color_key(key) return true end

for _, value in pairs(sub_interfaces) do
    for name, i in pairs(value) do
        if t[name] == nil then
            t[name] = i
        end
    end
end

return t