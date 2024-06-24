---@class Frameworks
local t = {}

function t:get_plugin_name()
    return ""
end

function t:now()
    return 0
end

function t:print(...) end

function t:log_without_print(...)end

function t:when_player_change()
    return {}
end

function t:bot_name()
    return ""
end

function t:get_neomega_player()
    return {}
end

return t