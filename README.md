# AurCore

AurCore (简称 AC 库) 是专为 NeOmega 平台设计的 Lua 前置库。它旨在NeOmega基础上进一步简化 Lua 插件的开发过程，并提供一套强大的工具来增强插件功能。

## 特性

- **易于安装**：简单几步即可集成到 NeOmega 插件中。
- **开发友好**：提供清晰的 API，使插件开发更加直观。
- **高度可配置**：灵活的配置选项以适应不同的开发需求。

## 安装指南

要在 NeOmega 中安装 AurCore，请按照以下步骤操作：

1. 从页面下载最新版的 AurCore 库文件。
2. 将下载的库文件解压获得的 `aurcore.lua` 放到 NeOmega 目录下的 `neomega_storage/lang/LuaLoader` 文件夹中。

## 快速上手

下面是一个简单的示例，指导您如何在 NeOmega 插件中快速集成 AurCore：

```lua
local omega = require("omega")
local coromega = require("coromega").from(omega)
local ac = require("aurcore").from(coromega)
```

## 版本兼容性
为确保插件与 AC 库的兼容性，推荐在插件代码运行前执行版本检查。您可以在[version.lua](https://github.com/Aurilia0617/aurcore/blob/main/config/version.lua)文件中查看当前支持的版本号，并在插件中进行相应的检查，如果当前库版本不兼容要求版本则会报错：

```lua
-- 假设 version.lua 文件中定义的当前版本是 Alpha-v0.1.0
local needAcVersion = "Alpha-v0.1.0"
ac:check_version(needAcVersion)
```

## 库版本与单文件版本
发行版release为单文件本版，旨在简化安装与使用。

库版本通过[node-lua-distiller](https://github.com/Aurilia0617/node-lua-distiller)进行单文件化。

因此要求库版本尽量注意全局变量的使用，它将在整个项目可见。

## 单元测试
内置了luaunit进行测试
```lua
ac:test()   -- return LuaUnit.LuaUnit.run()
```

## 参与贡献
欢迎任何形式的贡献，无论是功能建议、问题报告还是代码提交。如果您有任何想法或建议，请通过[ISSUES](https://github.com/Aurilia0617/aurcore/issues)页面告知我。

## WIKI
[AurCore Wiki](https://github.com/Aurilia0617/aurcore/wiki)

## 免责声明

本库按“原样”提供，不提供任何形式的明示或暗示的保证，包括但不限于适销性、适合特定目的和不侵权的保证。作者或版权持有人不对任何直接、间接、偶然、特殊、惩戒性或后果性损害负责，包括但不限于利润损失、数据丢失、业务中断或其他商业损害或损失，无论这些损害是由于合同、侵权行为（包括疏忽）、违反保证或其他原因引起的，即使已被告知可能发生此类损害。

用户应自行承担使用本库的风险，并负责确保软件满足其特定需求，以及在使用过程中采取适当的安全措施和备份数据。

本免责声明是本库许可证的一部分，使用本库即表示您同意接受本免责声明的条款。