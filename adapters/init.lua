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

function adapters:get_color()
    return require("aurcore.adapters.internal.utils.color.convert")
end

function adapters:get_pubsub()
    return require("aurcore.adapters.third_party.pubsub.convert")
end

function adapters:get_logger()
    return require("aurcore.adapters.internal.modules.logger.convert")
end

return adapters