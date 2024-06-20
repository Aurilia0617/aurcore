--- @class LanguageManager
local LanguageManager = {
    _currentLanguage = nil,
    _supportedLanguages = {
        en = true,
        zh = true
    }
}

function LanguageManager:set_language(lang)
    assert(LanguageManager._supportedLanguages[lang],
        string.format("Unsupported language code '%s'. Available languages are: %s.",
            tostring(lang),
            table.concat(LanguageManager:get_supported_languages(), ", ")))
            LanguageManager._currentLanguage = lang
end

function LanguageManager:get_language()
    return LanguageManager._currentLanguage or "en"
end

function LanguageManager:get_supported_languages()
    local languages = {}
    for lang, _ in pairs(LanguageManager._supportedLanguages) do
        table.insert(languages, lang)
    end
    return languages
end

function LanguageManager:is_language_supported(lang)
    return LanguageManager._supportedLanguages[lang] == true
end

return LanguageManager
