local Pubsub = require("aurcore.lib.pubsub.pubsunb")
local Types = require("aurcore.hub"):get_types()

local pubsubClass = Types:new_class("pubsubClass")

function pubsubClass:initialize()
    local new = Pubsub.new()
    function new:get_pubsub()
        return new
    end
end

function pubsubClass:pub(name, ...)
    return self:get_pubsub().pub(name, ...)
end

function pubsubClass:sub(name, callback)
    return self:get_pubsub().sub(name, callback)
end

function pubsubClass:sub_once(name, callback)
    return self:get_pubsub().sub_once(name, callback)
end

function pubsubClass:sub_many(name, callback, num)
    return self:get_pubsub().sub_many(name, callback, num)
end

return pubsubClass