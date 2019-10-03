# [MyBatis Generator](http://www.mybatis.org/generator/)

## Introduction

MyBatis Generator 是一个代码生成器。它会审查数据库表，然后生成可进入表的 artifact。MBG 目标是对数据库的大部分操作产生影响，主要是简单的 CRUD（Create, Retrieve, Update, Delete）。你仍需要手写 SQL 代码使用 join 查询或者存储程序。

MyBatis Generator 将会生成：

- Java POJOs，匹配表结构的 Java POJOs。这些可能包括：
  - 一个类，匹配表主键的（如果有一个主键）
  - 一个类，匹配表的非主键域（除了 BLOB 域）
  - 一个类，包含表的 BLOB 域（如果包含 BLOB 域）
  - 一个类，允许动态 selects, updates, deletes.

在这些类之间有合适的继承关系。注意生成器可以配置为生成不同类型的 POJO 层级- 例如，你可能选择为你选择的表生成单个的 domain 对象。

- Mybatis/iBATIS 兼容的 SQL MAP XML 文件。MBG 为在配置中的每个表生成简单的 CRUD 功能的 SQL。生成的 SQL 包含：
  - insert
  - update by primary key
  - update by example(using a dynamic where clause)
  - delete by primary key
  - delete by example(using a dynamic where clause)
  - select by a primary key
  - select by example(using a dynamic where clause)
  - count by example

取决于表结构，有很多语句的不同变种（例如，如果表没有主键，MBG 不会生成根据主键更新表的函数）。

- Java 客户端类合适的使用以上对象。Java client 类的生成是可选的。MBG 将为 MyBatis 3.x 生成下列类型的 Java client：
  - 一个与 MyBatis 3.x mapper 基础工作的 mapper 接口，MBG 将为 iBATIS 2.x 生成下列类型的 Java 客户端：
  - 符合 Spring framework 的 DAOs
  - DAOs 只用 iBATIS SQL 映射 API。这些 DAO 可以以两种方式生成：通过构造器或者 setting 注入提供 `SqlMapClient`。
  - 符合 iBATIS DAO 框架的 DAOs（iBATIS 的可选部分，这个框架现在废弃了，我们建议你用 spring framework 代替）。

  MyBatis generator 被设计为在迭代式开发环境运行得很好，可以被包含为一个 Ant 认为或者一个 Maven 包，在一个持续构建的环境。当迭代运行 MBG 时需要谨记：

    1. MBG 会自动合并 XML 文件，如果已有一个和新生成的 XML 名字相同的文件的话。MBG 不会重写你对它生成的 XML 文件的任何自定义改变。你可以一次又一次的运行而不会丢失你的 XML 的改变。MBG 会之前运行生成的任何 XML 元素。
    2. MBG 不会合并 Java 文件，它覆盖已存在的文件或者保存新生成的文件以一个不同的名字。如果你对生成的 Java 文件做出了改变，并且迭代的运行 MBG，你可能必须手动合并改变。当作为一个 Eclipse 包时，MBG 将自动合并 Java 文件。

### 依赖

MBG 不依赖一起拿的 JRE。需要 JRE 6.0 或以上。同样，JDBC driver 去要实现 DatabaseMetaData 接口，尤其需要 `getColumns` 和 `getPrimaryKeys` 方法。

## Quick Start Guide

为了快速上手运行 MBG（MyBatis Generator），跟随以下步骤：

1. 创建和填充合适的配置文件。至少应该明确：
    1. 一个 `<jdbcConnection>` 元素明确如何连接到目标数据库。
    2. 一个 `<javaModelGenerator>` 元素明确生成 Java model 对象的目标包和目标项目。
    3. 一个 `<sqlMapGenerator>` 元素明确生成的 SQL map 文件的目标包和目标项目。
    4. （可选的）一个 `<javaClientGenerator>` 元素明确生成的客户端接口和类的目标报和目标项目（如果你不想要生成 java 客户端的话，你可能想省略 `<javaClientGenerator>` ）。

查看 `[XML Configuration File Reference](http://www.mybatis.org/generator/configreference/xmlconfig.html) 查看配置实例文件。

2. 保存文件在方便的地方。
3. 像下面这样在命令行运行 MBG：

```CMD
 java -jar mybatis-generator-core-x.x.x.jar -configfile \temp\generatorConfig.xml -overwrite
 ```

 ## Running MuBatis Generator

 - 根据 XML 配置从命令行运行
 - 作为一个 [Maven Plugin](http://www.mybatis.org/generator/running/runningWithMaven.html)
 - 从另一个有 XML 配置的 Java Program
 - 从另一个基于 Java 配置的 Java program
 - 从一个 Eclipse Feature
 - 作为一个有 XML 配置的 Ant 任务

 ### [Running MyBatis Generator From a Command Prompt][0]

 ```CMD
java -jar mybatis-generator-core-x.x.x.jar -configfile generatorConfig.xml
   java -jar mybatis-generator-core-x.x.x.jar -configfile generatorConfig.xml -overwrite
   java -cp mybatis-generator-core-x.x.x.jar org.mybatis.generator.api.ShellRunner -configfile generatorConfig.xml
   java -cp mybatis-generator-core-x.x.x.jar org.mybatis.generator.api.ShellRunner -configfile generatorConfig.xml -overwrite
 ```

 ### [Running MyBatis Generator With Maven][1]

 在项目中包含一个 maven 包：

 ```XML
<project ...>
     ...
     <build>
       ...
       <plugins>
        ...
        <plugin>
          <groupId>org.mybatis.generator</groupId>
          <artifactId>mybatis-generator-maven-plugin</artifactId>
          <version>1.3.7</version>
        </plugin>
        ...
      </plugins>
      ...
    </build>
    ...
  </project>
 ```

MBG Maven Plugin 包含一个目标：
- mybatis-generator:generate

这个目标不会被 Maven 自动执行。可以通过两种方式执行。可以从命令行执行：

- `mvn mybatis-generator:generate`

可以传递标准的 Maven 命令行属性。例如：

- `mvn -Dmybatis.generator.overwrite=true mybatis-generator:generate`

在一个持续构建环境，你可能想作为 Maven 构建自动执行 MBG。这可以通过配置目标来自动完成。一个示例如下：

```XML
<project ...>
     ...
     <build>
       ...
       <plugins>
        ...
        <plugin>
          <groupId>org.mybatis.generator</groupId>
          <artifactId>mybatis-generator-maven-plugin</artifactId>
          <version>1.3.7</version>
          <executions>
            <execution>
              <id>Generate MyBatis Artifacts</id>
              <goals>
                <goal>generate</goal>
              </goals>
            </execution>
          </executions>
        </plugin>
        ...
      </plugins>
      ...
    </build>
    ...
  </project>
```

MBG 包绑定了 Maven 构建短语 `generate-sources`，因此它在编译前将自动执行。同样注意，MBG 同时生成了源文件和 XML 资源。MBG 目标将绑定 Java 文件 和 XML 资源文件并同时被打包到 JAR 文件中。

#### MyBatis Generator Configuration Properties

任何在 POM 中明确的属性都会被传递给配置文件，可通过正常方式使用。例如：

```XML
 <project ...>
     ...
     <properties>
       <dao.target.dir>src/main/java</dao.target.dir>
     </properties>
     ...
     <build>
       ...
       <plugins>
        ...
        <plugin>
          <groupId>org.mybatis.generator</groupId>
          <artifactId>mybatis-generator-maven-plugin</artifactId>
          <version>1.3.7</version>
          <executions>
            <execution>
              <id>Generate MyBatis Artifacts</id>
              <goals>
                <goal>generate</goal>
              </goals>
            </execution>
          </executions>
        </plugin>
        ...
      </plugins>
      ...
    </build>
    ...
  </project>
```

这种情况，这个 property 可以在配置文件中以 `${dao.target.dir}` 语法访问。

#### Classpath Issues

最初，包类路径很有限- 它只包含 MyBatis genetator 本身。如果你需要添加依赖到类路径（例如，一个 JDBC driver），你可以想下列方式添加依赖：

```XML  
<project ...>
     ...
     <build>
       ...
       <plugins>
        ...
        <plugin>
          <groupId>org.mybatis.generator</groupId>
          <artifactId>mybatis-generator-maven-plugin</artifactId>
          <version>1.3.7</version>
          <executions>
            <execution>
              <id>Generate MyBatis Artifacts</id>
              <goals>
                <goal>generate</goal>
              </goals>
            </execution>
          </executions>
          <dependencies>
            <dependency>
              <groupId>org.hsqldb</groupId>
              <artifactId>hsqldb</artifactId>
              <version>2.3.4</version>
            </dependency>
          </dependencies>
        </plugin>
        ...
      </plugins>
      ...
    </build>
    ...
  </project>
```

#### 参数参考 Parameter Reference

### [MyBatis Generator XML Configuration File Reference][2]

下面是一个 MBG 配置文件示例：

```XML
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE generatorConfiguration
  PUBLIC "-//mybatis.org//DTD MyBatis Generator Configuration 1.0//EN"
  "http://mybatis.org/dtd/mybatis-generator-config_1_0.dtd">

<generatorConfiguration>
  <classPathEntry location="/Program Files/IBM/SQLLIB/java/db2java.zip" />

  <context id="DB2Tables" targetRuntime="MyBatis3">
    <jdbcConnection driverClass="COM.ibm.db2.jdbc.app.DB2Driver"
        connectionURL="jdbc:db2:TEST"
        userId="db2admin"
        password="db2admin">
    </jdbcConnection>

    <javaTypeResolver >
      <property name="forceBigDecimals" value="false" />
    </javaTypeResolver>

    <javaModelGenerator targetPackage="test.model" targetProject="\MBGTestProject\src">
      <property name="enableSubPackages" value="true" />
      <property name="trimStrings" value="true" />
    </javaModelGenerator>

    <sqlMapGenerator targetPackage="test.xml"  targetProject="\MBGTestProject\src">
      <property name="enableSubPackages" value="true" />
    </sqlMapGenerator>

    <javaClientGenerator type="XMLMAPPER" targetPackage="test.dao"  targetProject="\MBGTestProject\src">
      <property name="enableSubPackages" value="true" />
    </javaClientGenerator>

    <table schema="DB2ADMIN" tableName="ALLTYPES" domainObjectName="Customer" >
      <property name="useActualColumnNames" value="true"/>
      <generatedKey column="ID" sqlStatement="DB2" identity="true" />
      <columnOverride column="DATE_FIELD" property="startDate" />
      <ignoreColumn column="FRED" />
      <columnOverride column="LONG_VARCHAR_FIELD" jdbcType="VARCHAR" />
    </table>

  </context>
</generatorConfiguration>
```

## [Using the Generated Objects][3]

MyBatis Generator(MBG) 生成下列类型的对象：

  1. [Java Model Objects][4] (always)
  2. [SQL Map Files][5] (always for iBATIS，usually for MyBatis)
  3. [Java Client Objects][6](optional)
  4. 类使用的 xxxByExample 方法。查看下列页面获取信息：
     - [Example Class Usage Notes][7]
     - [Extending the Example Classes][8]

## MyBatis Generator Generated Java Model Classes

### Example Class Usage Notes

example class 明确了怎样构建一个动态的 where 子句。

example class 包含了一个内部类 `Criteria`，包含了要添加到 where 子句中的一系列状态。

`Criteria` 对象可以用 `createCriteria` 或者 `or` 方法创建。

#### Simple Queries

```Java
 TestTableExample example = new TestTableExample();

  example.createCriteria().andField1EqualTo(5);
```

```Java
 TestTableExample example = new TestTableExample();

  example.createCriteria().andField1EqualTo(5);
```

#### Complex Queries

```Java
TestTableExample example = new TestTableExample();

  example.or()
    .andField1EqualTo(5)
    .andField2IsNull();

  example.or()
    .andField3NotEqualTo(9)
    .andField4IsNotNull();

  List<Integer> field5Values = new ArrayList<Integer>();
  field5Values.add(8);
  field5Values.add(11);
  field5Values.add(14);
  field5Values.add(22);

  example.or()
    .andField5In(field5Values);

  example.or()
    .andField6Between(3, 7);

```

上述例子中，动态生成下列 where 子句:

```SQL
where (field1 = 5 and field2 is null)
     or (field3 <> 9 and field4 is not null)
     or (field5 in (8, 11, 14, 22))
     or (field6 between 3 and 7)
```

#### Criteria Classes

`Criteria` 内部类包含了每个属性域的 `andXXX` 方法。

## [MyBatis Dynamic SQL Usage Notes][9]

## [Philosophy and Apology][10]



[0]: http://www.mybatis.org/generator/running/runningFromCmdLine.html
[1]: http://www.mybatis.org/generator/running/runningWithMaven.html
[2]: http://www.mybatis.org/generator/configreference/xmlconfig.html
[3]: http://www.mybatis.org/generator/generatedobjects/results.html
[4]: http://www.mybatis.org/generator/generatedobjects/javamodel.html
[5]: http://www.mybatis.org/generator/generatedobjects/sqlmap.html
[6]: http://www.mybatis.org/generator/generatedobjects/javaclient.html
[7]: http://www.mybatis.org/generator/generatedobjects/exampleClassUsage.html
[8]: http://www.mybatis.org/generator/generatedobjects/extendingExampleClass.html
[9]: http://www.mybatis.org/generator/generatedobjects/dynamicSql.html
[10]: http://www.mybatis.org/generator/philosophy.html

