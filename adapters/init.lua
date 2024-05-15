local adapters  = {
    _CONST = {
        _name = "adapters"
    }
}

function adapters:get_class()
    return require("aurcore.adapters.third_party.class.convert")
end

function adapters:get_i18n()
    return require("aurcore.adapters.internal.utils.i18n.convert")
end

function adapters:get_test_lib()
    return require("aurcore.adapters.third_party.unit_test.convert")
end

return adapters