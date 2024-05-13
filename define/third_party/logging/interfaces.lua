local check_method = require("aurcore.define.third_party.check")
local LoggingInterface = {}
local LoggerInterface = {}

-- 需要实现的方法
function LoggingInterface:new() end

function LoggerInterface:log() end

function LoggerInterface:debug() end

function LoggerInterface:info() end

function LoggerInterface:warn() end

function LoggerInterface:error() end

function LoggerInterface:fatal() end

return function (LoggerManagerLib)
    check_method(LoggerManagerLib,LoggingInterface)
    check_method(LoggerManagerLib:new(function(self, level, message)
        print(level, message)
        return true
      end),LoggerInterface)
end