local hub = {
    _CONST = {
        _name = "hub" -- 适配混入表类型
    }
}

-- 惰性引用防止循环引用

function hub:get_config()
    return require("aurcore.config")
end

function hub:inject(dep)
    return require("aurcore.core.inject"):inject(dep)
end

function hub:get_types()
    return require("aurcore.types.init")
end

function hub:get_class()
    return require("aurcore.define.class"):check(require("aurcore.adapters.init"):get_class())
end

function hub:get_i18n()
    return require("aurcore.define.init"):check_i18n(require("aurcore.adapters.init"):get_i18n()):new(self:get_config())
end

function hub:get_test_lib()
    return require("aurcore.define.init"):check_test_lib(require("aurcore.adapters.init"):get_test_lib())
end

function hub:get_color()
    return require("aurcore.define.init"):check_color(require("aurcore.adapters.init"):get_color())
end

function hub:get_test()
    return require("aurcore.test.init")
end

return hub