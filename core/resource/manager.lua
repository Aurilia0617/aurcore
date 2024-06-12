local hub = require("aurcore.hub")
local wrapper = require("aurcore.core.wrapper.init")
--- @class resoueceM:Class
--- @field resource resource
local resoueceMClass = hub:new_class("resoueceMClass")
local collaborator = require("aurcore.core.collaborator.init")

function resoueceMClass:new_ac()
    return wrapper:new(self.resource)
end

resoueceMClass:init(function (instance,resource)
    instance.resource = resource
    instance.collaborator = collaborator:new(resource)
end)

return resoueceMClass