local Hub = require("aurcore.hub")
local color = Hub:get_color()

local resource = require("aurcore.core.resource.init")

function resource:get_color()
    return color
end

return resource