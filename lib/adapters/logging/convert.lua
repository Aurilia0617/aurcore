local Logging = require("aurcore.lib.vendor.logging.logging")
local Types = require("aurcore.types.init")

local logging = Types:new_obj("logging")

function logging:new(append, startLevel)
    return Logging.new(append, startLevel)
end

function logging:set_format(t, default)
    return Logging.defaultLogPatterns(Logging.buildLogPatterns(t, default))
end

return logging
