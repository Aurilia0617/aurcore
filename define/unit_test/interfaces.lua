--- @class unitTest
local unitTestInterface = {}

-- 需要实现的方法
function unitTestInterface:run() end

function unitTestInterface:equals(actual, expaceted) end

function unitTestInterface:error_contains(fun,errorMsg) end

return unitTestInterface