local pool = require("aurcore.modules.pool")

local function add_modules(resources)
    local mixin_t = pool:mixin()
    for _, adapter_instance in ipairs(mixin_t) do
        for key, _ in pairs(adapter_instance._interface) do
            resources[key] = adapter_instance:get_adapter()[key]
        end
    end
end

return add_modules