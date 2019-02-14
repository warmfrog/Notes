


## spring 之旅

为了简化java开发的复杂性，spring 采取以下4中策略

* 基于POJO的轻量级和最小侵入性编程；
* 通过依赖注入和面向接口实现松耦合
* 基于切面和惯例进行声明式编程；
* 通过切面和模板减少样板式代码

### 依赖注入 (Dpendency Inject)

创建应用组件之间协作的行为通常称为装配（wiring). XML 是常见的一种装配方式。Spring 通过应用上下文（Application Context） 装在bean的定义并将它们组装起来。Spring应用上下文全权负责对象的创建和组装。Spring自带了多种应用上下文的实现，它们之间的区别在于如何加载配置。

* 构造器注入

### 应用切面

面向切面编程 (aspect-oriented programming)

