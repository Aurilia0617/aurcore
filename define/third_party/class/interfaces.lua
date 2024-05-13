local check_method = require("aurcore.define.third_party.check")

local classInterface = {}
local classLibInterface = {}

-- 需要实现的方法
function classLibInterface:new_class() end

function classInterface:include() end

function classInterface:subclass() end

return function (classLib)
    check_method(classLib,classLibInterface)
    check_method(classLib:new_class("defineTest"),classInterface)
end