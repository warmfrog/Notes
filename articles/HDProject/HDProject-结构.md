# 公司项目结构

一个功能模块是一个项目，命名以组件 Component 的形式。一个项目包含三个模块,结构如下

- component
  - client
  - dao
  - service

dao 负责数据持久化部分，service 包含具体的业务逻辑和 api 接口，client 包含对外调用的 接口。

## client 模块

### 项目依赖

client 模块依赖封装的 `st-framework-client` 模块。如下：

```XML
<dependency>
            <groupId>com.eg.egsc.framework</groupId>
            <artifactId>st-framework-client</artifactId>
        </dependency>
```

### `st-framework-client` 

该组件为封装的 `jar` 组件，`Maven` 依赖如下：

#### `pom.xml`

```XML
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
	<modelVersion>4.0.0</modelVersion>
	<parent>
		<groupId>com.eg.egsc.framework</groupId>
		<artifactId>st-framework</artifactId>
		<version>0.2.0</version>
	</parent>
	
	<artifactId>st-framework-client</artifactId>
	<packaging>jar</packaging>
	<name>st-framework-client</name>
	<description>st-framework-client project</description>

	<dependencies>
		<dependency>
			<groupId>org.springframework.cloud</groupId>
			<artifactId>spring-cloud-starter-eureka</artifactId>
		</dependency>
		<dependency>
			<groupId>org.springframework.cloud</groupId>
			<artifactId>spring-cloud-starter-feign</artifactId>
		</dependency>
		<dependency>
			<groupId>com.eg.egsc.component</groupId>
			<artifactId>st-component-base</artifactId>
		</dependency>
		<dependency>
			<groupId>com.eg.egsc.component</groupId>
			<artifactId>st-component-log</artifactId>
		</dependency>
		<dependency>
			<groupId>com.eg.egsc.component</groupId>
			<artifactId>st-component-kafka</artifactId>
		</dependency>
		<dependency>
			<groupId>com.eg.egsc.component</groupId>
			<artifactId>st-component-sequence</artifactId>
		</dependency>
		<dependency>
			<groupId>com.eg.egsc.component</groupId>
			<artifactId>st-component-auth</artifactId>
		</dependency>		
		<dependency>  
		    <groupId>org.springframework.boot</groupId>  
		    <artifactId>spring-boot-starter-aop</artifactId>  
		</dependency>
		<!--<dependency>
			<groupId>org.springframework.kafka</groupId>
			<artifactId>spring-kafka</artifactId>
		</dependency>-->
<!-- 		<dependency>
			<groupId>com.eg.egsc.scp.logservice</groupId>
			<artifactId>scp-logservice-component-client</artifactId>
			<version>1.2.2-SNAPSHOT</version>
		</dependency> -->
	</dependencies>

</project>
```

#### client 依赖

### client 代码分析

#### 项目结构

- com
  - eg
    - egsc
      - framework
        - client
          - core
          - dto
          - mq
          - util
        - logservice
          - dto
        - logwhitelist



    
        











