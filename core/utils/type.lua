local function is_array(t)
    if type(t) ~= "table" then return false end
    local i = 0
    for k in pairs(t) do
        i = i + 1
        if t[i] == nil then return false end
    end
    return true
end

return {
    is_array = is_array
}