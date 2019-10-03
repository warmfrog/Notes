# Android-Cookbook 学习笔记

三个月前学的android,现在全还给姥姥了. 重新复习回顾以下.

## Getting Started

### 1.1 理解android应用架构

一个android应用通常包含一个或多个下列组件,被写成java类的形式.

* Activity: 活动组成了屏幕的可视界面, 代码在屏幕上显示数据,响应屏幕的用户事件.
* Service: 服务是没有用户界面的组件,可以比Activity运行更长的时间.两个Service的主要应用是
长时间运行的任务, 以及不会影响用户交互的中等长度的任务.
* Broadcast receivers: 广播接收相对不是很常用, 被用来响应系统级的事件,例如网络关闭,重获连接,电池低,系统重启,等等.
* Content providers 内容提供商相当少见,被用来共享一个应用自己的数据给其他应用;它们与同步适配器(sync adapter)一起使用.
* Sync adapters 同步适配器云云服务同步数据;最好的例子是设备上的日历和通讯录, 可以轻松使用你的谷歌账户同步.

你的代码不像传统java那样使用`new`操作符创建这些对象,而是使用`Intent`请求`Activities`,`Services`等的调用. Intent,一个明确你的意图的对象. Intent可以启动你的应用的`Activities`, 启动其他应用的Activities,启动`Servicies`,请求其他操作.

### 1.2 理解Androoid Activity的声明周期

app经历下列生命周期:

```java
void onCreate(Bundle savedInstanceState)
void onStart()
void onResume()
void onRestart()
void onPause()
void onStop()
void onDestroy()
```

