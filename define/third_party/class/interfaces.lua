local check_method = require("aurcore.define.check")
---@class classInterface
local classInterface = {}
---@class classLibInterface
local classLibInterface = {}

-- 需要实现的方法
function classLibInterface:new_class() end

function classInterface:set_static_val() end

function classInterface:get_static_val() end

function classInterface:include() end

function classInterface:subclass() end

return function (classLib)
    check_method(classLib,classLibInterface)
    check_method(classLib:new_class("defineTest"),classInterface)
    ---@class classLibInterface
    return classLib
end