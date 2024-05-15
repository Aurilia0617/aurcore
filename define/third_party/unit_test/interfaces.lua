local check_method = require("aurcore.define.check")
local unitTestInterface = {}

-- 需要实现的方法
function unitTestInterface:run() end

function unitTestInterface:equals() end

function unitTestInterface:error_contains() end

return function (unitTestLib)
    check_method(unitTestLib,unitTestInterface)
    return unitTestLib
end