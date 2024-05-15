local types = require("aurcore.hub"):get_types()

local define = types:new_obj("define")
-- class 比较底层，因此单开文件特别供应（防止循环引用），不放在这

function define:check_test_lib(UnitTestLib)
    return require("aurcore.define.third_party.unit_test.interfaces")(UnitTestLib)
end

-- function define:check_logging(LoggerLib)
--     return require("aurcore.define.internal.utils.logging.interfaces")(LoggerLib)
-- end

function define:check_i18n(I18nLib)
    return require("aurcore.define.internal.utils.i18n.interfaces")(I18nLib)
end

function define:check_color(ColorLib)
    return require("aurcore.define.internal.utils.color.interfaces")(ColorLib)
end

return define