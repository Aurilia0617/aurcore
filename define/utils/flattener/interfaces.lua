--- @class flattener
local flattenerInterface = {}

function flattenerInterface:flatten(t, dataName) end

function flattenerInterface:unflatten(t, dataName) end

function flattenerInterface:init(uuid_generator) end

return flattenerInterface