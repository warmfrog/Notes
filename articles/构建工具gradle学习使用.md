# 构建工具gradle学习使用

### [Getting Started](https://gradle.org/guides/#getting-started)

### 简介

Gradle 是一个开源的自动集成工具关注于灵活性和性能。Gradle构建脚本使用Groovy或者Kotlin DSL.

### 特点

* 高度自定义- Gradle在最基础的方法中被打造成自定义和可扩展的。
* 快速- Gradle重用以前执行的输出快速完成任务，只有当输入改变时才会处理，并行执行任务。
* 强大- Gradle是Android的官方构建工具，生来支持很多流行语言和技术。

### 安装

官网地址<https://gradle.org>，当前最新版本为Feb 08 2019 发布的[gradle-v5.2.1](https://services.gradle.org/distributions/gradle-5.2.1-bin.zip)。安装并添加到环境变量,确保JAVA_HOME已设置。

## 创建新的Gradle Builds

### 初始化项目

```bash
mkdir basic-demo
cd basic-demo
gradle init
```

![gradle_init](/img/gradle_init.png)

### 创建任务

Gradel通过提供基于Groovy或者Kotlin的DSL的API创建和配置任务。一个项目包含了任务的集合，每个执行基本操作。

你可以利用Gradle自带的任务库在你自己的项目中配置。例如，有一个核心类型叫 Copy，复制文件从一个位置到另一个位置。Copy任务非常有用。如下，定义一个复制任务。

build.gradle

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

### 应用一个包(Apply a plugin)

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

### 探索和调试构建

发现可获得的任务

```bash
./gradlew tasks
```

tasks 命令列出你可以调用的 Gradle tasks， 包括 *base* 包添加的，和你自定义的任务

```text
❯ ./gradlew tasks

> Task :tasks

------------------------------------------------------------
All tasks runnable from root project
------------------------------------------------------------

Archive tasks
-------------
zip - Archives sources in a zip file

Build tasks
-----------
assemble - Assembles the outputs of this project.
build - Assembles and tests this project.
clean - Deletes the build directory.

Build Setup tasks
-----------------
init - Initializes a new Gradle build.
wrapper - Generates Gradle wrapper files.

Custom tasks
------------
copy - Simply copies sources to a the build directory

Help tasks
----------
buildEnvironment - Displays all buildscript dependencies declared in root project 'basic-demo'.
components - Displays the components produced by root project 'basic-demo'. [incubating]
dependencies - Displays all dependencies declared in root project 'basic-demo'.
dependencyInsight - Displays the insight into a specific dependency in root project 'basic-demo'.
dependentComponents - Displays the dependent components of components in root project 'basic-demo'. [incubating]
help - Displays a help message.
model - Displays the configuration model of root project 'basic-demo'. [incubating]
projects - Displays the sub-projects of root project 'basic-demo'.
properties - Displays the properties of root project 'basic-demo'.
tasks - Displays the tasks runnable from root project 'basic-demo'.

Verification tasks
------------------
check - Runs all checks.

Rules
-----
Pattern: clean<TaskName>: Cleans the output files of a task.
Pattern: build<ConfigurationName>: Assembles the artifacts of a configuration.
Pattern: upload<ConfigurationName>: Assembles and uploads the artifacts belonging to a configuration.

To see all tasks and more detail, run gradlew tasks --all

To see more detail about a task, run gradlew help --task <task>

BUILD SUCCESSFUL in 0s
1 actionable task: 1 executed
```

#### 解释

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

### 分析和调试你的构建

Gradle 同样提供一个丰富的基于web的试图被称作 build scan

![build scan.png](/img/build_scan.png)

通过使用 --scan 选项，可以免费发表构建。 发表构建通过传输这个数据到 Gradle 服务器 <https://scans.gradel.com>. Gradle企业版支持保存数据。

```text
❯ ./gradlew zip --scan

BUILD SUCCESSFUL in 0s
1 actionable task: 1 up-to-date

Publishing a build scan to scans.gradle.com requires accepting the Terms of Service defined at https://scans.gradle.com/terms-of-service. Do you accept these terms? [yes, no]
Gradle Cloud Services license agreement accepted.

Publishing build scan...
https://gradle.com/s/repnge6srr5qs
```

### 发现可获得的属性

`properties` 命令告诉你项目的属性

```bash
./gradlew properties
```

```text
> Task :properties

------------------------------------------------------------
Root project
------------------------------------------------------------

buildDir: /Users/.../basic-demo/build
buildFile: /Users/.../basic-demo/build.gradle
description: null
group:
name: basic-demo
projectDir: /Users/.../basic-demo
version: unspecified

BUILD SUCCESSFUL
```

## 构建java web 应用

Gradle包含一个war包来构建java web应用。社区提供了一个优秀的包gretty来测试和部署web应用在Jetty或者Tomcat上。

### 创建web应用结构

```text
webdemo/
    src/
        main/
            java/
            webapp/
        test
            java/
```

### 添加一个Gradle构建文件 build.gradle

```groovy
plugins{
    id 'war'
}
respositories{
    jcenter()
}
dpendencies{
    provideCompile 'javax.servlet:javax.servlet-api-3.1.0'
    testCompile 'junit:junit:4.12'
}
```

war包添加了配置 providedCompile 和 providedRuntime, 类似与 java 应用中的 编译 和 运行， 用来在本地显示需要的依赖但是不应添加到生成的 webdemo.war 文件。

plugins 语法用来应用 java 和 war 包。不需要指定版本，因为他们包含在 Gradle 构建版本中。

通过执行 `wrapper` 任务来生成一个Gradle wrapper是一个很好的联系。

```bash
gradle wrapper --gradle-version=4.10-rc-2
:wrapper
```

这会生成 `gradle` 和 `gradlew.bat` 脚本和 *gradle* 文件夹下的wrapper jar。

## [命令行接口(Command-Line Interface)](https://docs.gradle.org/4.10-rc-2/userguide/command_line_interface.html)

命令行接口之与 `Gradle` 交互的主要方法之一。下面是一些执行和自定义使用 Gradle在命令行下的一些参考。

使用 [Gradle Wrapper](https://docs.gradle.org/4.10-rc-2/userguide/gradle_wrapper.html#gradle_wrapper)是很推荐的。当你使用wrapper的时候，在下列示例中，你应该使用   `gradle` 替代 `./gradle` or `gradlew.bat`。

当在命令建行下执行 Gradle 的时候，确保下列的结构

```bash
gradle [taskName...] [--option-name...]
```

如果有多个任务，应该以空格分隔。

选项接受参数，可以使用 = 在选项和参数之间，也可以不使用。

```bash
--console=plain
```

选项运行长形式的参数取反 --no-.

```bash
--build-cache
--no-build-cache
```

很多长参数有缩写

```shell
--help
-h
```

很多命令行标志可以在 `gradle.preperties` 中声明来避免键入。查看[configuring build environment guide](https://docs.gradle.org/4.10-rc-2/userguide/build_environment.html#sec:gradle_configuration_properties).

### 执行任务

```bash
gradle myTask
```

#### 多任务执行

子项目任务使用 “: 区分项目名和任务名

```bash
❯ gradle :mySubproject:taskName
❯ gradle mySubproject:taskName
```

#### 执行多个任务

```bash
❯ gradle test deploy
```

#### 排除任务

排除任务使用 -x 或者 --exclude-task

![command execute tasks](/img/commandLineTutorialTasks.png)

```text
> gradle dist --exclude-task test

> Task :compile
compiling source

> Task :dist
building the distribution

BUILD SUCCESSFUL in 0s
2 actionable tasks: 2 executed
```

#### 强迫任务执行

强迫Gradle执行任务忽略 up-to-date check 使用 --rerun-tasks

```bash
❯ gradle test --rerun-tasks
```

#### 当失败发生时继续构建

默认，Gradle终止执行当任务失败时。但是这样隐藏了其他可能失败的任务。 使用--continue选项避免

```bash
❯ gradle test --continue
```

### 常用任务

#### 计算所有输出

`gradle build`

#### 运行应用

`gradle run`

#### 运行所有检查

`gradle check`

#### 清理输出

`gradle clean`

### 项目报告

Gradle提供构建的细节帮助你理解构建的结构和依赖。使用 `gradle help` 查看报告选项。

#### 列出项目

`gradle projects`

#### 列出任务

```bash
gradle tasks
gradle tasks --all
```

#### 显示任务细节

`gradle help --task someTask`

获取任务细节帮助

```text
> gradle -q help --task libs
Detailed task information for libs

Paths
     :api:libs
     :webapp:libs

Type
     Task (org.gradle.api.Task)

Description
     Builds the JAR

Group
     build
```

### 报告依赖

Build scans 提供一个完整的可视化的依赖

`gradle myTask --scan`

#### 列出项目依赖

`gradle dependencies`

可视化构建环境

`gradle buildEnvironment`

列出项目属性

`gradle properties`

属性信息

```text
> gradle -q api:properties

------------------------------------------------------------
Project :api - The shared API for the application
------------------------------------------------------------

allprojects: [project ':api']
ant: org.gradle.api.internal.project.DefaultAntBuilder@12345
antBuilderFactory: org.gradle.api.internal.project.DefaultAntBuilderFactory@12345
artifacts: org.gradle.api.internal.artifacts.dsl.DefaultArtifactHandler_Decorated@12345
asDynamicObject: DynamicObject for project ':api'
baseClassLoaderScope: org.gradle.api.internal.initialization.DefaultClassLoaderScope@12345
```

#### [软件模型](https://docs.gradle.org/4.10-rc-2/userguide/software_model.html#software_model)报告

### 命令行补全

Gradle为 tasks, options提供bash和zsh tab 补全支持。

## [构建Java 应用](https://guides.gradle.org/building-java-applications/)

Gradle 拥有一个内建包 [Init](https://docs.gradle.org/current/userguide/build_init_plugin.html) 包。

这个包有一个任务 init, 生成项目。init任务调用 `wrapper` 任务生成 Gradle wrapper 脚本，gradlew.

### Setup

```bash
mkdir demo
cd demo
```

### 运行 init 任务

```bash
gradle init --type java-applicaiton
```

```test
$ gradle init --type java-application
Select build script DSL:
  1: groovy
  2: kotlin
Enter selection (default: groovy) [1..2]

Select test framework:
  1: junit
  2: testng
  3: spock
Enter selection (default: junit) [1..3]

Project name (default: demo):
Source package (default: demo):

BUILD SUCCESSFUL
```

init 任务首先运行 wrapper 任务，生成 gradlew 和 gradlew.bat 打包脚本。 然后创建下面的结构

```text
├── build.gradle
├── gradle    
│   └── wrapper
│       ├── gradle-wrapper.jar
│       └── gradle-wrapper.properties
├── gradlew
├── gradlew.bat
├── settings.gradle
└── src
    ├── main
    │   └── java  
    │       └── demo
    │           └── App.java
    └── test      
        └── java
            └── demo
                └── AppTest.java
```

### 查看生成的项目文件

settings.gradle

```text
rootProject.name = 'demo'
```

build.gradle

```groovy
plugins {
    id 'java'
    id 'application'
}

repositories {
    //公共的二进制产品仓库
    jcenter()
}

dependencies {
    //Google Guava 库
    implementation 'com.google.guava:guava:26.0-jre'
    //Junit 测试库
    testImplementation 'junit:junit:4.12'
}

//主方法类
mainClassName = 'demo.App'
```

src/mian/java/App.java

```java
package demo;

public class App {
    public String getGreeting() {

        return "Hello world.";
    }

    public static void main(String[] args) {
        System.out.println(new App().getGreeting());
    }
}
```

src/test/java/AppTest.java

```java
package demo;

import org.junit.Test;
import static org.junit.Assert.*;

public class AppTest {
    @Test public void testAppHasAGreeting() {
        App classUnderTest = new App();
        assertNotNull("app should have a greeting", classUnderTest.getGreeting());
    }
}
```

### 执行构建

```text
$ ./gradlew build
> Task :compileJava
> Task :processResources NO-SOURCE
> Task :classes
> Task :jar
> Task :startScripts
> Task :distTar
> Task :distZip
> Task :assemble
> Task :compileTestJava
> Task :processTestResources NO-SOURCE
> Task :testClasses
> Task :test
> Task :check
> Task :build

BUILD SUCCESSFUL
8 actionable tasks: 8 executed
```

第一次执行wrapper脚本时， gradlew， 会有延迟当gradle 下载并存储到~/.gradle/wrapper/dists 目录时。

第一次运行构建时，Gradle会检查你是否有 *Guava* 和 *JUnit* 库在缓存目录 ~/.gradle。
如果没有则下载。

可以查看测试报告的  HTML 形式，位于 build/reports/tests/test/index.html.

### 运行 应用

查看任务

```text
$ ./gradlew tasks
:tasks

------------------------------------------------------------
All tasks runnable from root project
------------------------------------------------------------

Application tasks
-----------------
run - Runs this project as a JVM application

// ... many other tasks ...
```

运行

```text
$ ./gradlew run
> Task :compileJava UP-TO-DATE
> Task :processResources NO-SOURCE
> Task :classes UP-TO-DATE

> Task :run
Hello world.

BUILD SUCCESSFUL in 0s
2 actionable tasks: 1 executed, 1 up-to-date


BUILD SUCCESSFUL
```

## [构建和运行Spring Boot 应用](https://guides.gradle.org/building-spring-boot-2-projects-with-gradle/)














