local check_method = require("aurcore.define.check")
local PubsubLibInterface = {}
local PubsubInterface = {}

-- 需要实现的方法

function PubsubLibInterface:new() end

function PubsubInterface:pub() end

function PubsubInterface:sub() end

function PubsubInterface:sub_once() end

function PubsubInterface:sub_many() end

return function (PubsubLib)
    check_method(PubsubLib,PubsubLibInterface)
    check_method(PubsubLib:new(),PubsubInterface)
    return PubsubLib
end