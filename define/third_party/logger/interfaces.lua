local check_method = require("aurcore.define.third_party.check")
local LoggerInterface = {}

-- 需要实现的方法
function LoggerInterface:new() end

return function (LoggerLib)
    check_method(LoggerLib,LoggerInterface)
end