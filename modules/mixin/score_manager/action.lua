local hub = require("aurcore.hub")
local i18n = hub:get_i18n()
local function action(resource, data)
    assert(type(data) == "table", i18n:error_msg("incorrect_type_table", type(data)))
    assert(type(data.action) == "string", i18n:error_msg("incorrect_type_string", type(data.action)))
    assert(type(data.data) == "table", i18n:error_msg("incorrect_type_table", type(data.data)))
    if data.action == "lock_with_tag" then
        assert(data.tag ~= nil, i18n:error_msg("key_not_exist", "data.tag"))
    elseif data.action == "unlock_with_tag" then
        assert(data.tag ~= nil, i18n:error_msg("key_not_exist", "data.tag"))
    else
        error(i18n:error_msg("key_not_exist", data.action))
    end
end
