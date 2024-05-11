## v0.1.0-Alpha.1
该版本设置了接口及其使用规则：
- 所有接口位于`core/interfaces`下
- 从三方库到工具集，需要符合`core/interfaces/third_party`下的接口
- 从工具集到资源管理，需要符合`core/interfaces/internal/utils`下的接口
- 从模块到资源管理，需要符合`core/interfaces/internal/modules`下的接口

接口定义实现方法函数存在的弱检测,方便三方库的更换或者工具集、模块重写后的对接

添加了一些成功的实践：
- 从三方库到工具集：单元测试功能
- 从工具集到资源管理：国际化功能
- 从模块到资源管理：AC主模块的装载

添加了一些更新规则：
- 更换三方库时，重写`adapters`下的相应适配器以适应`core/interfaces/third_party`下定义的接口
- 重写工具集时，需要适应`core/interfaces/internal/utils`下定义的接口
- 重写模块时，需要适应`core/interfaces/internal/modules`下定义的接口