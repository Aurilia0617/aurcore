-- 注意顺序（重写）
local sub_interfaces = {
    require("aurcore.define.core.logger.expose")
}
---@class Logger:LoggerExpose
local t = {}

for _, value in pairs(sub_interfaces) do
    for name, i in pairs(value) do
        if t[name] == nil then
            t[name] = i
        end
    end
end

--- @class LoggerManager
local t2 = {}

--- 创建新的日志对象
--- @return Logger 返回新的日志对象
function t2:new()
    return {}
end

return {
    logger_manager_interface = t2,
    logger_interface = t
}