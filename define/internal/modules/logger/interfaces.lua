--- @class LoggerModule
local LoggerLibInterface = {}
--- @class Logger
local LoggerInterface = {}

--- @return Logger
function LoggerLibInterface:new() return {} end

function LoggerInterface:set_log_name() end

function LoggerInterface:get_log_name() end

function LoggerInterface:set_log_level() end

function LoggerInterface:get_log_level() end

function LoggerInterface:fatal() end

function LoggerInterface:error() end

function LoggerInterface:warn() end

function LoggerInterface:info() end

function LoggerInterface:succ() end

function LoggerInterface:debug() end

function LoggerInterface:set_debug_stack_depth() end

return {
    LoggerLibInterface = LoggerLibInterface,
    LoggerInterface = LoggerInterface
}