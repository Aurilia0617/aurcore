--- @class Config
local config = {
    version = "v0.1.0-Alpha.6",
    currentLanguage = "en",
    default_log_level = 2, -- 1:只播报Fatal，2:添加Error播报，3:添加Warning播报，4:添加Success播报，5:添加Info播报，6:添加Debug播报
    default_debug_stack_depth = 2,
    logo = [[        
  █████╗ ██╗   ██╗██████╗  ██████╗ ██████╗ ██████╗ ███████╗
 ██╔══██╗██║   ██║██╔══██╗██╔════╝██╔═══██╗██╔══██╗██╔════╝
 ███████║██║   ██║██████╔╝██║     ██║   ██║██████╔╝█████╗  
 ██╔══██║██║   ██║██╔══██╗██║     ██║   ██║██╔══██╗██╔══╝  
 ██║  ██║╚██████╔╝██║  ██║╚██████╗╚██████╔╝██║  ██║███████╗
 ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝ ]],
    logo_color = [[        
  █████%r╗ ██%r╗   ██%r╗██████%r╗  ██████%b╗ ██████%b╗ ██████%b╗ ███████%b╗
 ██%r╔══██%r╗██%r║   ██%r║██%r╔══██%r╗██%b╔════╝██%b╔═══██%b╗██%b╔══██%b╗██%b╔════╝
 ███████%r║██%r║   ██%r║██████%r╔╝██%b║     ██%b║   ██%b║██████%b╔╝█████%b╗  
 ██%r╔══██%r║██%r║   ██%r║██%r╔══██%r╗██%b║     ██%b║   ██%b║██%b╔══██%b╗██%b╔══╝  
 ██%r║  ██%r║╚██████%r╔╝██%r║  ██%r║%b╚██████%b╗╚██████%b╔╝██%b║  ██%b║███████%b╗
 %r╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝ %b╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝ ]],
    collaborator_tag = "e638689e-45a2-4fe4-aded-6211d272b882-AurCore-Plugin-Collaborator",
    ac_log_name = "Aur-Core"
}
return config