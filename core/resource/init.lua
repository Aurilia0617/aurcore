local Types = require("aurcore.types.init")
local ResourceClass = Types.class:new("ResourceClass")
local AurCoreClass = Types.class:new("AurCoreClass")

function AurCoreClass:initialize(frameworkContainer)
    function self:test()
        return frameworkContainer.test()
    end
end

function ResourceClass:initialize(frameworkContainer)
    self.get_ac = function (_)
        return AurCoreClass:new(frameworkContainer)
    end
end

return ResourceClass