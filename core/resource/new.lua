local resource = {_name_ = "resource"}
local wrapper = require("aurcore.core.wrapper.init")
local utils = require("aurcore.utils.table.init")

return {
    resource = resource,
    init = function (framework)
        setmetatable(resource, {__index = framework})
    end,
    new_wrapper = function ()
        return utils:add_as_priority(resource, wrapper:new(resource))
    end
}