return function (func)
    local executed = false
    local result = nil

    return function(...)
        if not executed then
            executed = true
            result = func(...)
        end
        return result
    end
end