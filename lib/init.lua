local library = require("aurcore.types.init"):new_obj("library")
-- middleclass 比较底层，因此单开文件特别供应（防止循环引用），不放在这

function library:get_luaunit()
    local luaunit = require("aurcore.lib.adapters.luaunit.convert")
    require("aurcore.define.init"):check_unit_test(luaunit)
    return luaunit
end

return library
