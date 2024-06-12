local hub = require("aurcore.hub")
local config = hub:get_config()
local win = require("aurcore.utils.validators.win_or_unix").win
local color = hub:get_color()

local collaboratorClass = hub:new_class("collaboratorClass")

collaboratorClass:init(function(instance, resource)
    local logger = hub:get_logger(resource, "Aur-Core")
    instance.was_init = false
    resource:start_new(function ()
        local sm = resource:shared_map()
        local data,loaded = sm:load_or_store("e638689e-45a2-4fe4-aded-6211d272b882-AurCore-Plugin-Collaborator",{
            core_version = config.version,
            datas = {},
            ac_plugins = {}
        })
        if not loaded then
            -- 创建流程
            -- 打印logo
            if win then
                print(config.logo .. config.version .. "\n")
            else
                print(
                    string.gsub(
                    string.gsub(string.gsub(config.logo_color, "%%b", color:get_fg_color("2D")), "%%r",
                        color:get_fg_color("C5")), "%█", color:get_fg_color("F") .. "█") ..
                    color:get_fg_color("2E") .. color:get_bold_color() .. config.version .. color:get_reset_color() .. "\n"
                )
            end
            logger:succ("ac库协作中心初始化完成")
        else
            -- 加入流程
            -- 版本验证
            -- 加入播报
        end
        logger:info(("协作中心加入插件：%s"):format(resource:get_plugin_name()))
        instance.was_init = true
    end)
end)

return collaboratorClass
