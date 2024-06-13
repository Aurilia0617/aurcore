local hub = require("aurcore.hub")
return function(container)
    return hub:new_container({
        hub:get_lock_manager(container)
    })
end
