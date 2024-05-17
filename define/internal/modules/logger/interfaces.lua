local check_method = require("aurcore.define.check")

local LoggerLibInterface = {}
local LoggerInterface = {}

function LoggerLibInterface:new() end

function LoggerInterface:set_log_name() end

function LoggerInterface:get_log_name() end

return function (LoggerLib)
    check_method(LoggerLib,LoggerLibInterface)
    check_method(LoggerLib:new({
        log = function () end,
        print = function () end,
        get_plugin_name = function () end,
    },"interfaceTest"),LoggerInterface)
    return LoggerLib
end