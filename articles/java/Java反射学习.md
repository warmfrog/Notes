# [java 反射(Reflection)](https://docs.oracle.com/javase/tutorial/reflect/index.html)

反射(Reflection)在那些需要拥有测量和修改在java虚拟机中运行的程序的运行时行为的程序很常用. 这是相当高级的特性,只应该被深入理解语言基础的开发者使用. 牢记,反射是强大的技术,允许应用执行正常情况下不可能的操作.

* 扩展特性: 一个应用可能充分利用外部的,用户定义的类通过使用他们的完全限定名创建可扩展的对象实例.

* 类浏览器和虚拟开发环境: 类浏览器需要用来枚举类成员. 虚拟开发环境受益于在反射中充分获得类型信息来帮助开发者写正确的代码.

* 调试器和测试工具: 调试器需要用来测量类的私有成员. 测试充分利用反射系统的调用定义的类的API集合, 确保测试代码收敛的高度.

## Classes

每种类型不是引用类型就是原生类型, 类(Classes),枚举(enums),数组(arrays)(都继承自java.lang.Object)与接口都是引用类型. 引用类型包括java.lang.String, 所有原生类型的封装类如: java.lang.Double, 接口 java.io.Serializable, 枚举 javax.swing.SortOrder. 不变的原生类型: boolean, byte, short, int, long, char, float, double.

每种对象类型, Java虚拟机实例化一个java.lang.Class类,提供方法来测试对象的运行时属性包括成员和类型信息.
Class 同样提供创建新类和对象的能力. 最重要的是,它是所有反射API(Reflection API)的起点. 

### 提取类对象(Retrieving Class Objects)

所有反射操作的起点是 `java.lang.Class`. 伴着 `java.lang.reflect.ReflectPermission` 异常的存在, `java.lang.reflect`中没有类拥有公共构造器. 为了获得这些类, 需要调用Class上合适的方法. 有几种不同的方式获得一个类(Class), 这取决于 代码是否能够进入对象, 类名,类型, 或者一个已存在的类.

#### Object.getClass()

如果一个对象的实例可获得,那么最简单的方法获得它的类是调用 Object.getClass(). 当然,这只对引用类型有效.

```java
Class c = "foo".getClass();
```

```java
Class c = System.console().getClass();
```

与虚拟机相关的独特的控制台, 由静态方法 System.console()返回. getClass() 返回的类是 `java.io.Console`.

```java
enum E{A,B}
Class c = A.getClass();
```

A 是枚举E的实例, 因此 getClass() 返回枚举类型E.

```java
byte[] bytes = new byte[1024];
Class c = bytes.getClass();
```

因为数据是对象,所以同样可以在一个数组实例上调用getClass()方法. 返回的类是一个数组对应组件类型byte.

```java
import java.util.HashSet;
import java.util.Set;

Set<String> s = new HashSet<String>();
Class c = s.getClass();
```

这种情况, `java.util.Set` 是`java.util.HashSet`对象的接口. getClass()返回 `java.util.HashSet`.

#### .class语法

如果一个类型可以获得,但是没有实例,那么可以通过追加 .class 到类名上获得一个类. 这也是最简单的方法获得原生类型的类.

```java
boolean b;
Class c = b.getClass(); //compile-time error

Class c = boolean.class; //correct
```

因为 `boolean` 是原生类型,不能被 dereferenced. .class 语法返回对应的boolean类型.

```java
Class c = java.io.PrintStream.class;
```

变量c返回对应的类型为 `java.io.PrintStream`

```java
Class c = int[][][].class;
```

返回多维数组类型.

#### Class.forName()

如果类的完全限定名可以获得, 可以通过静态方法 `Class.forName()` 获取相应类. 这不能是原生类型. 数组类的名字语法描述为 `Class.getName()`. 这个语法可以应用到引用和原生类型.

```java
Class c = Class.forName("com.duke.MyLocaleServiceProvider");
```

这个语句会创建一个类,根据给的类的完全限定名.

```java
Class cDoubleArray = Class.forName("[D");

Class cStringArray = Class.forName("[[Ljava.lang.String;");
```

cDoubleArray 变量包含原生类型double的数组. cStringArray变量包含字符串的二维数组类(String [][].class).
