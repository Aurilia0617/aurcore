local check_method = require("aurcore.define.third_party.check")
local unitTestInterface = {}

-- 需要实现的方法
function unitTestInterface:run() end

function unitTestInterface:equals() end

function unitTestInterface:error_contains() end

return function (unitTestLib)
    check_method(unitTestLib,unitTestInterface)
end