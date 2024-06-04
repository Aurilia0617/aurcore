--- @class unitTest
local unitTestInterface = {}

function unitTestInterface:run() end

function unitTestInterface:equals(actual, expaceted) end

function unitTestInterface:error_contains(fun,errorMsg) end

return unitTestInterface