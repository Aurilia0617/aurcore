# AurCore

AurCore (简称 AC 库) 是专为 NeOmega 平台设计的 Lua 前置库。它旨在NeOmega基础上进一步简化 Lua 插件的开发过程，并提供一套强大的工具来增强插件功能。

## 特性

- **易于安装**：简单一行代码即可集成到 NeOmega 插件中。
- **开发友好**：提供清晰的 API，使插件开发更加直观。
- **高度可配置**：灵活的配置选项以适应不同的开发需求。

## 世界观
### kernel/
>较底层的核心逻辑，负责模块之间以及库整体到外部框架的对接。

### kernel/utils/adapter_checker
>检查传入的适配器是否符合接口定义（弱检查），通过检查的适配器在库外可以通过`ac:replace_adapter(<tag>, <new_adapter>)`进行替换，下述为库中支持替换的tag，适配器要求的接口定义详见define。

    <tag>  <描述>
    class：库使用的面向对象机制
    i18n:
    color:

### kernel/class/
>提供类和混入表的接口，在该层之上的导出对象均使用二者定义。