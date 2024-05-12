-- 当类定义在三方库和内置库之间切换时才需要改这里的require路径
return {
    _CONST = { _name = "library" }, -- 适配混入表类型
    get = function(_)
        return require("aurcore.define.third_party.class.interfaces")
    end,
    check = function(_, classLib)
        return require("aurcore.define.third_party.class.check")(classLib)
    end
}
