# [Mybatis](https://github.com/mybatis)

## [Get Started](http://www.mybatis.org/mybatis-3/getting-started.html)

### Installtion

```xml
<dependency>
  <groupId>org.mybatis</groupId>
  <artifactId>mybatis</artifactId>
  <version>x.x.x</version>
</dependency>
```

### Building SqlSessionFactory from XML

每个 MyBatis 应用以 `SqlSessioonFactory` 为中心。一个 `SqlSessionFacory` 实例可以用 `SqlSessionFactoryBuilder` 获得。 `SqlSessionFactoryBuilder` 可以从一个 XML 配置文件构建一个 `SqlSessioonFactory`,或者从一个自定义的 Configuration 类。

MyBatis 包含一个工具类，叫做 `Resources`，包含很多方法从类路径或其他位置载入资源。

```Java
String resource = "org/mybatis/example/mybatis-config.xml";
InputStream inputStream = Resources.getResourceAsStream(resource);
SqlSessionFactory sqlSessionFactory =
  new SqlSessionFactoryBuilder().build(inputStream);
```

XML 配置文件包含 MyBatis 系统的核心，包含获取数据库连接实例的 DataSource,和一个决定事务范围和控制的 `TransactionManager`。下例是个简单的配置：

```XML
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE configuration
  PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
  "http://mybatis.org/dtd/mybatis-3-config.dtd">
<configuration>
  <environments default="development">
    <environment id="development">
      <transactionManager type="JDBC"/>
      <dataSource type="POOLED">
        <property name="driver" value="${driver}"/>
        <property name="url" value="${url}"/>
        <property name="username" value="${username}"/>
        <property name="password" value="${password}"/>
      </dataSource>
    </environment>
  </environments>
  <mappers>
    <mapper resource="org/mybatis/example/BlogMapper.xml"/>
  </mappers>
</configuration>
```

### Building SqlSessionFactory without XML

MyBatis 提供完整的配置类提供了和 XML 一样多的配置选项。

```Java
DataSource dataSource = BlogDataSourceFactory.getBlogDataSource();
TransactionFactory transactionFactory =
  new JdbcTransactionFactory();
Environment environment =
  new Environment("development", transactionFactory, dataSource);
Configuration configuration = new Configuration(environment);
configuration.addMapper(BlogMapper.class);
SqlSessionFactory sqlSessionFactory =
  new SqlSessionFactoryBuilder().build(configuration);
```

### Acquiring a SqlSession Factory from SqlSessionFactory

```Java
try (SqlSession session = sqlSessionFactory.openSession()) {
  Blog blog = session.selectOne(
    "org.mybatis.example.BlogMapper.selectBlog", 101);
}
```

或者尝试一个更清新的方法，使用一个接口类：

```Java
try (SqlSession session = sqlSessionFactory.openSession()) {
  BlogMapper mapper = session.getMapper(BlogMapper.class);
  Blog blog = mapper.selectBlog(101);
}
```

### Exploring Mapped SQL Statements

MyBatis 支持 XML 映射和 annotation。下面是一个基于 XML 的声明。

```XML
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper
  PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
  "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="org.mybatis.example.BlogMapper">
  <select id="selectBlog" resultType="Blog">
    select * from Blog where id = #{id}
  </select>
</mapper>
```

通过下列方式调用：

```Java
Blog blog = session.selectOne(
  "org.mybatis.example.BlogMapper.selectBlog", 101);
```

下面是一种更简便的调用方法：

```Java
BlogMapper mapper = session.getMapper(BlogMapper.class);
Blog blog = mapper.selectBlog(101);
```

通过 annotation 标记接口 Mapper 类：

```Java
package org.mybatis.example;
public interface BlogMapper {
  @Select("SELECT * FROM blog WHERE id = #{id}")
  Blog selectBlog(int id);
}
```

### Scope and Lifecycle

#### SqlSessionFactoryBuilder

这个类可以实例化，使用和丢弃。一旦创建完 `SqlSessionFactory` 后，就没有必要留着了。因此最好的范围是方法里。

#### SqlSessionFactory

SqlSessionFactory 应该存在你的应用执行期间。没有理由重建它。

#### SqlSession

每个线程都该有它自己的 `SqlSession` 实例。`SqlSession` 实例不能被共享，是线程不安全的。因此最好的范围是方法域。不要在每个类实例的范围里引用一个静态 SqlSession 实例。最好不要在一个 HttpSession 会话里保存实例。一个 HTTP 请求对应一个  `SqlSession` 实例，请求完成， `SqlSession` 就应该被关闭。

### Mapper Instances

Mappers 是接口，你可以创建它来绑定你的 mapper 生命。mapper 接口实例可以从 `SqlSession` 中获得。mapper 最好的范围应放在方法域。

## [配置](http://www.mybatis.org/mybatis-3/configuration.html)

MyBatis 配置包含设置和属性，轮廓如下：

- configuration
  - properties
  - settings
  - typeAliases
  - typeHandlers
  - objectFactory
  - plugins
  - environments
    - environment
      - transactionManager
      - dataSource
  - databaseIdProvider
  - mappers

### properties

一些可外部化的、可替代的属性可以在一个典型的 Java Properties 文件实例中，或者通过属性的子元素。例如：

```XML
<properties resource="org/mybatis/example/config.properties">
  <property name="username" value="dev_user"/>
  <property name="password" value="F2Fa3!33TYyg"/>
</properties>
```

之后属性文件中的属性可以在配置文件中引用。例如：

```XML
<dataSource type="POOLED">
  <property name="driver" value="${driver}"/>
  <property name="url" value="${url}"/>
  <property name="username" value="${username}"/>
  <property name="password" value="${password}"/>
</dataSource>
```

自 MyBatis 3.4.2，你可以明确一个占位符的默认值，像下面一样：

```XML
<dataSource type="POOLED">
  <!-- ... -->
  <property name="username" value="${username:ut_user}"/> <!-- If 'username' property not present, username become 'ut_user' -->
</dataSource>
```

这个特点默认是禁用的，如果要允许这样，在属性中添加下列：

```XML
<properties resource="org/mybatis/example/config.properties">
  <!-- ... -->
  <property name="org.apache.ibatis.parsing.PropertyParser.enable-default-value" value="true"/> <!-- Enable this feature -->
</properties>
```

### [settings](http://www.mybatis.org/mybatis-3/configuration.html#settings)

下面是一个全配置的例子：

```XML
<settings>
  <setting name="cacheEnabled" value="true"/>
  <setting name="lazyLoadingEnabled" value="true"/>
  <setting name="multipleResultSetsEnabled" value="true"/>
  <setting name="useColumnLabel" value="true"/>
  <setting name="useGeneratedKeys" value="false"/>
  <setting name="autoMappingBehavior" value="PARTIAL"/>
  <setting name="autoMappingUnknownColumnBehavior" value="WARNING"/>
  <setting name="defaultExecutorType" value="SIMPLE"/>
  <setting name="defaultStatementTimeout" value="25"/>
  <setting name="defaultFetchSize" value="100"/>
  <setting name="safeRowBoundsEnabled" value="false"/>
  <setting name="mapUnderscoreToCamelCase" value="false"/>
  <setting name="localCacheScope" value="SESSION"/>
  <setting name="jdbcTypeForNull" value="OTHER"/>
  <setting name="lazyLoadTriggerMethods"
    value="equals,clone,hashCode,toString"/>
</settings>
```

### typeAliases

一个类型别名是一个 Java 类型的简称。如下：

```XML
<typeAliases>
  <typeAlias alias="Author" type="domain.blog.Author"/>
  <typeAlias alias="Blog" type="domain.blog.Blog"/>
  <typeAlias alias="Comment" type="domain.blog.Comment"/>
  <typeAlias alias="Post" type="domain.blog.Post"/>
  <typeAlias alias="Section" type="domain.blog.Section"/>
  <typeAlias alias="Tag" type="domain.blog.Tag"/>
</typeAliases>
```

可以明确 MyBatis 搜索 bean 的包名。例如：

```XML
<typeAliases>
  <package name="domain.blog"/>
</typeAliases>
```

每个在 `domain.blog` 发现的 bean，如果没有标记，会使用非首字母大写和非全限定名注册 bean。也就是说，`domain.blog.Author` 被注册为 `author`。如果 `@Alias` 标记被发现，那么它的值被用作别名。如下：

```XML
@Alias("author")
public class Author {
    ...
}
```

### [typeHandlers](http://www.mybatis.org/mybatis-3/configuration.html#typeHandlers)

无论何时 MyBatis 设置 `PreparedStatement` 或者从一个 `ResultSet` 提取值，一个 `TypeHandler` 都被用来提取值，对应 Java 类型。下列表描述了默认的 TypeHanders。







