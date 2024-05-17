local Pubsub = require("aurcore.lib.pubsub.pubsunb")
local Types = require("aurcore.hub"):get_types()

local pubsubClass = Types:new_class("pubsubClass")

function pubsubClass:initialize()
    local new = Pubsub.new()
    function pubsubClass:get_pubsub() -- 实际上self是实例
        return new
    end
end

function pubsubClass:pub(name, ...)
    return pubsubClass:get_pubsub().pub(name, ...)
end

function pubsubClass:sub(name, callback)
    return pubsubClass:get_pubsub().sub(name, callback)
end

function pubsubClass:sub_once(name, callback)
    return pubsubClass:get_pubsub().sub_once(name, callback)
end

function pubsubClass:sub_many(name, callback, num)
    return pubsubClass:get_pubsub().sub_many(name, callback, num)
end

return pubsubClass