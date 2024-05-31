local currentLanguage
local supportedLanguages = {
    en = true,
    zh = true
}
--- @class LanguageManager
local LanguageManager = {}

function LanguageManager:set_language(lang)
    assert(supportedLanguages[lang],
        string.format("Unsupported language code '%s'. Available languages are: %s.", tostring(lang),
            table.concat(self:get_supported_languages(), ", ")))
    currentLanguage = lang
end

function LanguageManager:get_language()
    return currentLanguage or "en"
end

function LanguageManager:get_supported_languages()
    local languages = {_name_ = "supportedLanguagesList"}
    for lang, _ in pairs(supportedLanguages) do
        table.insert(languages, lang)
    end
    return languages
end

return LanguageManager
