--- @class LoggerExpose
local t = {}

--- 设置日志名
--- @param name string 日志名
function t:set_log_name(name) end

--- 获取日志名
--- @return string 返回日志名
function t:get_log_name() return "" end

--- 设置日志级别
--- @param level string 日志级别
function t:set_log_level(level) end

--- 获取日志级别
--- @return number 返回日志级别
function t:get_log_level() return 0 end

--- 写入严重错误级别的日志
--- @param ... string 可变参数，日志信息
function t:fatal(...) end

--- 写入错误级别的日志
--- @param ... string 可变参数，日志信息
function t:error(...) end

--- 写入警告级别的日志
--- @param ... string 可变参数，日志信息
function t:warn(...) end

--- 写入信息级别的日志
--- @param ... string 可变参数，日志信息
function t:info(...) end

--- 写入成功级别的日志
--- @param ... string 可变参数，日志信息
function t:succ(...) end

--- 写入调试级别的日志
--- @param ... string 可变参数，日志信息
function t:debug(...) end

--- 设置调试堆栈深度
function t:set_debug_stack_depth() end

return t