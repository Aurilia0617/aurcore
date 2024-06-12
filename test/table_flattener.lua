local hub = require("aurcore.hub")
local ut = hub:get_test()
local testFlattener = { _name_ = "FlattenerTest" }

function testFlattener:setUp()
    -- 模拟框架提供的uuid函数
    function self:uuid()
        return "a7288f36-e165-4182-86b1-b9ccc13036d7"
    end

    function self:get_flattener()
        return hub:get_table_flattener(self)
    end
end

function testFlattener:test1()
    ut:equals(
        self:get_flattener():flatten({ ["ok"] = "hihi" }, "test_data"),
        {
            ["test_data"] = "a7288f36-e165-4182-86b1-b9ccc13036d7",
            ["a7288f36-e165-4182-86b1-b9ccc13036d7"] = "test_data",
            ["a7288f36-e165-4182-86b1-b9ccc13036d7-type"] = "map",
            ["a7288f36-e165-4182-86b1-b9ccc13036d7-len"] = 1,
            ["a7288f36-e165-4182-86b1-b9ccc13036d7-elem-1-key"] = "ok",
            ["a7288f36-e165-4182-86b1-b9ccc13036d7-elem-1-type"] = "val",
            ["a7288f36-e165-4182-86b1-b9ccc13036d7-elem-1-val"] = "hihi"
        }
    )
end

return testFlattener
