local utils = require("aurcore.utils.table.init")

--- @class InternalModule:BasicModule
--- @field _moduleList table<any, any>
local InternalModule = utils:add_tostring("InternalModuleInterface", { _moduleList = {} })
local mt = getmetatable(InternalModule)
mt.__index = require("aurcore.modle.module_basic")
setmetatable(InternalModule, mt)


return InternalModule
