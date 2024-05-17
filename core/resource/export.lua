local resource = require("aurcore.core.resource.init")

return {
    resource = resource,
    set_pre_framework = function (_, ...)
        resource:set_pre_framework(...)
        -- 此处有顺序要求，不要乱改
        require("aurcore.core.resource.color")
        require("aurcore.core.resource.logger")
        return resource
    end
}