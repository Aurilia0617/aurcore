---@class API:Color, versionChecker, Logger, container,Version, LockManager
local api = {_name_ = "AurCore"}

--- 获取测试运行函数
--- @return number @不通过测试的数量
function api:test() return 0 end

return api