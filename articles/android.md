

# windows下创建android项目

## 基础知识

#### 单位

* dp(dip) device independent pixels (设备独立像素)
* px(pixels)
* pt(point) 1pt = 1/72 英寸
* sp(scaled pixels)

## 环境配置

### 环境变量

* C:\Program Files\Android-SDK-Manager\tools

* C:\Program Files\Android-SDK-Manager\platform-tools

* ANT_HOME  C:\Program Files\apache-ant-1.10.5

* gradle4.1 C:\Program Files\Android Studio\gradle\gradle-4.1\bin

### gradle 仓库设置

    maven{
            url 'http://maven.aliyun.com/nexus/content/groups/public/'
        }

## 创建项目(默认ant构建)

    android create project --target android-23 --package com.example.foo --name Foo --activity HelloWorldAcitvity --path .\MyAndroidd

* --name 生成的.apk文件名称
* --gradle 使用Gradle 格式
* --gradleversion Gradle版本

### 项目目录

* AndroidManifext.xml 告知Android新建项目有关内容的配置文件
* bin 生成的二进制代码文件(编译好的类文件)
* build.properties 可编辑的属性文件
* build.xml Ant构建控制文件
* project.properties 保存所用到的SDK版本和库
* 其他已知文件

### 创建gradle构建项目

    android create project --target android-23 --package com.example.foo --gradle --gradle-version 4.6
--name Foo --activity HelloWorldActivity --path HelloGradle

### 构建项目

* ant 构建

    ant debug

* gradle 构建

   gradlew build 

### 部署到虚拟机

    android create avd -n my_droid -t 2 --abi default/x86_64

* android 调试桥服务器与模拟器进行通信

    adb start-server
    emulator -avd my_droid

## adb 使用

* 安装应用 
    adb install package.apk
* 卸载应用 
    adb uninstall com.exaple.packageName
* shell 打开手机shell
    adb shell
* 查看日志
    adb logcat

### ant 的缺点

ant 自身无法处理依赖项，而maven提供依赖项管理功能，maven是java环境中使用最广泛的构建工具

## 测试

### 常用缩略短语

* NPE (NUll Pointer Exception)
* ANR (Application Not Responding
* FC (Force Close)

### Android Studio

* 查看日志 View->Tool Window->logcat   alt + 6

#### 调试

利用Log.d() 方法可以方便进行android应用程序调试, 该方法在LogCat窗口输出必要的值和信息.

    import android.util.Log;
    Log.d("Testing", "Checkpoint 1");

Log.d() 方法不支持变量, 可以通过String.format()格式化输出.

#### 检查代码

    cmd: lint .
    androidStudio: Analyze->Inspect Code.

## HttpClient

因为android6.0 以后官方不在支持Httpclient

### 添加库

### httpclient

在模块build.properties 

* 在android{}标签中添加

    useLibrary 'org.apache.http.legacy'

* 在dependencies{}标签添加

    compile group: 'org.apache.httpcomponents', name: 'httpclient-android', version: '4.3.5.1'

### design 

* desgin 
    implementation 'com.android.support:design:26.0.0-beta1'
