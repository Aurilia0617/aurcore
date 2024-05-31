local utils = require("aurcore.utils.table.init")

--- @class BasicModule
--- @field _moduleList table<any, any>
local BasicModule = utils:add_tostring("BasicModuleInterface", { _moduleList = {} })

--- @param bm BasicModule
--- @param moduleName any
--- @return table
local function get_module(bm, moduleName)
    local module = bm._moduleList[moduleName]
    assert(module, ("The %s module does not exist"):format(moduleName))
    return module
end

--- @param moduleName any
--- @param property string
--- @param value any
function BasicModule:set_property(moduleName, property, value)
    local module = self._moduleList[moduleName] or {}
    assert(not module[property], ("The %s for %s already exists"):format(property, moduleName))
    module[property] = value
    self._moduleList[moduleName] = module
end

--- @param moduleName any
--- @param methodList table
function BasicModule:set_define(moduleName, methodList)
    self:set_property(moduleName, "methodList", methodList)
end

--- @param moduleName any
--- @param adapter any
function BasicModule:set_adapter(moduleName, adapter)
    self:set_property(moduleName, "adapter", adapter)
end

--- @param moduleName any
--- @param adapter any
function BasicModule:replace_adapter(moduleName, adapter)
    local module = get_module(self, moduleName)
    assert(module.adapter, ("The adapter for %s module does not exist"):format(moduleName))
    module.adapter = adapter
end

--- @param moduleName any
--- @return any
function BasicModule:get_adapter(moduleName)
    local module = get_module(self, moduleName)
    assert(module.adapter, ("The adapter for %s is not configured"):format(moduleName))
    assert(module.methodList, ("The methodList for %s is not configured"):format(moduleName))
    utils:check_method(moduleName, module.adapter, module.methodList)
    return module.adapter
end

return BasicModule
