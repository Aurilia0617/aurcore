local hub = require("aurcore.hub")
local wrapper = require("aurcore.core.wrapper.init")
--- @class resoueceM:Class
--- @field resource resource
local resoueceMClass = hub:new_class("resoueceMClass")

function resoueceMClass:new_ac()
    return wrapper:new(self.resource)
end

resoueceMClass:init(function (instance,resource)
    instance.resource = resource
end)

return resoueceMClass