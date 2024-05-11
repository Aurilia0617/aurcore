## v0.1.0-Alpha.1
该版本设置了接口及其使用规则：
- 所有接口位于`core/interfaces`下
- 从三方库到工具集，需要符合`core/interfaces/third_party`下的接口
- 从工具集到资源管理，需要符合`core/interfaces/internal/utils`下的接口
- 从模块到资源管理，需要符合`core/interfaces/internal/modules`下的接口

接口定义实现方法函数的存在检测，参数的类型检测以及返回类型的检测（尽可能）

添加了一些成功的实践：
- 从三方库到工具集：单元测试功能
- 从工具集到资源管理：国际化功能
- 从模块到资源管理：AC主模块的装载