local Language = require("aurcore.core.utils.i18n.language")
local Types = require("aurcore.types.init")

local dateTimeFormats = {
    en = {
        dateFormat = "%m/%d/%Y", -- U.S. style date format (Month/Day/Year)
        timeFormat = "%I:%M %p", -- 12-hour time format with AM/PM
        dateTimeFormat = "%m/%d/%Y %I:%M %p"
    },
    zh = {
        dateFormat = "%Y年%m月%d日", -- Chinese style date format (Year/Month/Day)
        timeFormat = "%H:%M", -- 24-hour time format
        dateTimeFormat = "%Y年%m月%d日 %H:%M"
    },
    de = {
        dateFormat = "%d.%m.%Y", -- German style date format (Day.Month.Year)
        timeFormat = "%H:%M",    -- 24-hour time format
        dateTimeFormat = "%d.%m.%Y %H:%M"
    }
}

local function get_date_time_format(key, customLang)
    local formats = dateTimeFormats[customLang or Language:get_language()]
    assert(formats, "Unknown language key: " .. tostring(customLang))
    local format = formats[key] or error("Unknown format key: " .. tostring(key))
    return format
end

local DateTimeFormats = Types.obj:new("DateTimeFormats")

function DateTimeFormats:get_date_format(customLang)
    return get_date_time_format('dateFormat', customLang)
end

function DateTimeFormats:get_time_format(customLang)
    return get_date_time_format('timeFormat', customLang)
end

function DateTimeFormats:get_date_time_format(customLang)
    return get_date_time_format('dateTimeFormat', customLang)
end

return DateTimeFormats
