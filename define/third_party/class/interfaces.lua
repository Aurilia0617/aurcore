local classInterface = {}
local classLibInterface = {}

-- 需要实现的方法
function classLibInterface:new_class() end

function classInterface:include() end

function classInterface:subclass() end

return {
    classInterface = classInterface,
    classLibInterface = classLibInterface
}
