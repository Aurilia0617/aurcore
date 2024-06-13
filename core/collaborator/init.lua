local hub = require("aurcore.hub")
local config = hub:get_config()
local win = require("aurcore.utils.validators.win_or_unix").win
local color = hub:get_color()
local i18n = hub:get_i18n()

local collaboratorClass = hub:new_class("collaboratorClass")

collaboratorClass:init(function(instance, resource)
    local logger = hub:get_logger(resource, config.ac_log_name)
    instance.was_init = false
    resource:start_new(function()
        local sm = resource:shared_map()
        local data, loaded = sm:load_or_store(config.collaborator_tag, {
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
                    color:get_fg_color("2E") ..
                    color:get_bold_color() .. config.version .. color:get_reset_color() .. "\n"
                )
            end
            logger:succ(i18n:text_msg("ac_collaborator_initialized"))
        else
            -- 加入流程
            -- 版本验证
            -- 加入播报
        end
        instance.was_init = true

        resource:sleep(0.01)
        logger:info(color:get_bold_color()..color:get_fg_color("green").."✚ "..color:get_reset_color()..i18n:text_msg("ac_collaborator_add_plugin",resource:get_plugin_name()))
    end)
end)

return collaboratorClass
