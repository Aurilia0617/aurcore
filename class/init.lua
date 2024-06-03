local bm = require("aurcore.hub"):get_basic_module()
bm:set_adapter("ClassLib", require("aurcore.class.adapter.class"))
bm:set_define("ClassLib", require("aurcore.class.define.class").classLibInterface)
bm:set_adapter("Class", require("aurcore.class.adapter.class"):new_class("Test"))
bm:set_define("Class", require("aurcore.class.define.class").classInterface)
bm:get_adapter("Class")
--- @type classLib
local ClassLib = bm:get_adapter("ClassLib")
return ClassLib