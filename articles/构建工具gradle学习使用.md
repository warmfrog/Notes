# 构建工具gradle学习使用

### 简介

Gradle 是一个开源的自动集成工具关注于灵活性和性能。Gradle构建脚本使用Groovy或者Kotlin DSL.

#### 特点

* 高度自定义- Gradle在最基础的方法中被打造成自定义和可扩展的。
* 快速- Gradle重用以前执行的输出快速完成任务，只有当输入改变时才会处理，并行执行任务。
* 强大- Gradle是Android的官方构建工具，生来支持很多流行语言和技术。

### 安装

官网地址<https://gradle.org>，当前最新版本为Feb 08 2019 发布的[gradle-v5.2.1](https://services.gradle.org/distributions/gradle-5.2.1-bin.zip)。安装并添加到环境变量,确保JAVA_HOME已设置。

### [Getting Started](https://gradle.org/guides/#getting-started)

#### 初始化项目

```bat
mkdir basic-demo
cd basic-demo
gradle init
```

![gradle_init](/img/gradle_init.png)

#### 创建任务

Gradel通过提供基于Groovy或者Kotlin的DSL的API创建和配置任务。一个项目包含了任务的集合，每个执行基本操作。

你可以利用Gradle自带的任务库在你自己的项目中配置。例如，有一个核心类型叫 Copy，复制文件从一个位置到另一个位置。Copy任务非常有用。如下，定义一个复制任务。

##### build.gradle

```groovy
task copy(type: Copy, group: "Custom", description: "Copies sources to the dest directory") {
    from "src"
    into "dest"
}
```

现在执行你的任务

```cmd
./gradlew copy
```

#### 应用一个包(Apply a plugin)

Gradle包含了很多包，很多可以在Gradel 包入口([the Gradle plugin portal](http://plugins.gradle.org/))获得。其中之一就有base包。结合核心类型Zip，你可以在你的项目中使用一个配置的名字和位置打包一个zip文档。

```Groovy
plugins{
    id "base"
}
```

现在添加一个打包zip文档的任务

```Groovy
task zip(type: Zip, group: "Archive", description: "Archives sources in a zip file") {
    from "src"
    setArchiveName "basic-demo-1.0.zip"
}
```

运行这个任务

```bash
./gradle zip
```

#### 自带的任务

查看任务类型

```bash
./gradlew tasks
```

##### 文档任务

* zip 打包zip文档

##### 构建任务

* assemble 装配项目输出
* build 装配项目和测试
* clean 删除构建目录

##### 构建建立任务

* init - 初始化一个Gradle构建
* wrapper - 生成Gradle wrapper 文件

##### 自定义任务

copy- 复制

##### 帮助任务

* buildEnvironment 显示所有构建脚本依赖
* componets 显示项目生成的组建
* dependencies 显示所有以来

```text
dependencyInsight - Displays the insight into a specific dependency in root project 'basic-demo'.
dependentComponents - Displays the dependent components of components in root project 'basic-demo'. [incubating]
help - Displays a help message.
model - Displays the configuration model of root project 'basic-demo'. [incubating]
projects - Displays the sub-projects of root project 'basic-demo'.
properties - Displays the properties of root project 'basic-demo'.
tasks - Displays the tasks runnable from root project 'basic-demo'.

Verification tasks

check - Runs all checks.

Rules

Pattern: clean<TaskName>: Cleans the output files of a task.
Pattern: build<ConfigurationName>: Assembles the artifacts of a configuration.
Pattern: upload<ConfigurationName>: Assembles and uploads the artifacts belonging to a configuration.

To see all tasks and more detail, run gradlew tasks --all

To see more detail about a task, run gradlew help --task <task>

BUILD SUCCESSFUL in 0s
1 actionable task: 1 executed
```
