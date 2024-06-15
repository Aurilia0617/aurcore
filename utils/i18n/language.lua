--- @class LanguageManager
local LanguageManager = {
    _currentLanguage = nil,
    _supportedLanguages = {
        en = true,
        zh = true
    }
}

--- 设置当前语言
--- @param lang string 语言代码
function LanguageManager:set_language(lang)
    assert(self._supportedLanguages[lang],
        string.format("Unsupported language code '%s'. Available languages are: %s.",
            tostring(lang),
            table.concat(self:get_supported_languages(), ", ")))
    self._currentLanguage = lang
end

--- 获取当前语言
--- @return string 当前的语言代码
function LanguageManager:get_language()
    return self._currentLanguage or "en"
end

--- 获取支持的语言列表
--- @return table 支持的语言代码列表
function LanguageManager:get_supported_languages()
    local languages = {}
    for lang, _ in pairs(self._supportedLanguages) do
        table.insert(languages, lang)
    end
    return languages
end

--- 检查给定的语言是否受支持
--- @param lang string 语言代码
--- @return boolean 是否支持
function LanguageManager:is_language_supported(lang)
    return self._supportedLanguages[lang] == true
end

return LanguageManager
