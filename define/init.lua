local Types = require("aurcore.types.init")

local define = Types:new_obj("define")
-- class 比较底层，因此单开文件特别供应（防止循环引用），不放在这

function define:check_unit_test(UnitTestLib)
    return require("aurcore.define.third_party.unit_test.check")(UnitTestLib)
end

return define