local check_method = require("aurcore.core.define.check")
local unitTestInterface = {}

-- 开始测试流程
function unitTestInterface:run() end
-- 等于测试
function unitTestInterface:equals() end
-- 错误并包含测试
function unitTestInterface:error_contains() end

return function (unitTestLib)
    check_method(unitTestLib,unitTestInterface)
    return unitTestLib
end