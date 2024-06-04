local meta = require("aurcore.utils.table.meta")
local flattener = require("aurcore.utils.table.flatten_table")

local t = {}
for key, value in pairs(meta) do
    t[key] = value
end
t.tableFlattener = flattener

return t