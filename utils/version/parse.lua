local function check_format_v_version_type_build(input)
    local pattern = "^v(%d+%.%d+%.%d+)%-(%w+)%.(%d+)$"
    local version, type, build = input:match(pattern)
    if version and type and build then
        return {version = version, type = type, build = build}
    end
    return nil
end

local function check_format_v_version(input)
    local pattern = "^v(%d+%.%d+%.%d+)$"
    local version = input:match(pattern)
    if version then
        return {version = version}
    end
    return nil
end

local function check_format_v_version_release(input)
    local pattern = "^v(%d+%.%d+%.%d+)%-(%w+)$"
    local version, type = input:match(pattern)
    if version and type then
        return {version = version, type = type}
    end
    return nil
end

local function check_format_release_v_version(input)
    local pattern = "^(%w+) v(%d+%.%d+%.%d+)$"
    local type, version = input:match(pattern)
    if version and type then
        return {version = version, type = type}
    end
    return nil
end

local function check_format_v_version_release_space(input)
    local pattern = "^v(%d+%.%d+%.%d+) (%w+)$"
    local version, type = input:match(pattern)
    if version and type then
        return {version = version, type = type}
    end
    return nil
end

local function check_format_release_dash_v_version(input)
    local pattern = "^(%w+)%-v(%d+%.%d+%.%d+)$"
    local type, version = input:match(pattern)
    if version and type then
        return {version = version, type = type}
    end
    return nil
end

-- 定义检查顺序和格式检查函数列表
local format_checkers = {
    check_format_v_version_type_build,
    check_format_v_version,
    check_format_v_version_release,
    check_format_release_v_version,
    check_format_v_version_release_space,
    check_format_release_dash_v_version
}

local function parse_version_string(input)
    for _, checker in ipairs(format_checkers) do
        local result = checker(input)
        if result then
            return result
        end
    end
    error("invalid version string")
end

-- 测试代码
-- local test_strings = {
--     "v1.0.0-Alpha.3",
--     "v2.1.0",
--     "v3.2.1-Beta.5",
--     "Release v0.0.1",
--     "v0.0.1-Releasehihi",
--     "v0.0.1 Relehiase",
--     "Release-v0.0.1",
--     "invalid_version_string"
-- }

-- for _, str in ipairs(test_strings) do
--     local result = parse_version_string(str)
--     if result then
--         print("Input:", str)
--         for k, v in pairs(result) do
--             print(k .. ":", v)
--         end
--     else
--         print("Input:", str, "does not match any known format.")
--     end
--     print("---")
-- end

return parse_version_string