# 封装组件

## 列表

- 1.
    - group ID: com.eg.egsc.component
    - *artifact ID*:
        - st-component-auth
        - st-component-base
        - st-component-job
        - st-component-kafka
        - st-component-lock
        - st-component-log
        - st-component-oss
        - st-component-redis
        - st-component-sequence
        - st-component-usercenter
        - st-component-audit
        - st-component-rabbitmq

- 2.
    - group ID: com.eg.egsc.framework
    - *artifact ID*:
      - st-framework
      - st-framework-client
      - st-framework-dao
      - st-framework-service
      - st-spring-boot-start-starnetworkjob
      - st-starnetwork-job-core

- 3.
    - group ID: com.eg.egsc.egc.commoncomponent
    - *artifact ID*:
      - egc-st-common-component-service

- 4.
    - group ID: com.eg.egsc.egc.mapanalysisapp
    - *artifact ID*:
      - egc-st-mapanalysis-app

- 5.
    - group ID: com.eg.egsc.logcomponent
    - *artifact ID*:
      - st-log-component-service
    
- 6.
    - group ID: com.eg.egsc.mdmcomponent
    - *artifact ID*:
      - st-mdm-component-client

- 7.
    - group ID: com.eg.egsc.ordermgmtcomponent
    - *artifact ID*:
      - egc-st-ordermgmt-client

## com.eg.egsc.framework

- group ID: com.eg.egsc.framework
    - *artifact ID*:
      - st-framework
      - st-framework-client
      - st-framework-dao
      - st-framework-service
      - st-spring-boot-start-starnetworkjob
      - st-starnetwork-job-core

### st-framework

#### parent

```XML
	<parent>
		<groupId>org.springframework.cloud</groupId>
		<artifactId>spring-cloud-starter-parent</artifactId>
		<version>Edgware.SR3</version>
		<relativePath /> <!-- lookup parent from repository -->
	</parent>
```

#### 依赖

```XML
	<dependencies>
			<dependency>
				<groupId>com.eg.egsc.component</groupId>
				<artifactId>st-component-base</artifactId>
				<version>${component.version}</version>
			</dependency>
			<dependency>
				<groupId>com.eg.egsc.component</groupId>
				<artifactId>st-component-log</artifactId>
				<version>${component.version}</version>
			</dependency>
			<dependency>
				<groupId>com.eg.egsc.component</groupId>
				<artifactId>st-component-sequence</artifactId>
				<version>${component.version}</version>
			</dependency>
			<dependency>
				<groupId>com.eg.egsc.component</groupId>
				<artifactId>st-component-audit</artifactId>
				<version>${component.version}</version>
			</dependency>
			<dependency>
				<groupId>com.eg.egsc.component</groupId>
				<artifactId>st-component-kafka</artifactId>
				<version>${component.version}</version>
			</dependency>
			<dependency>
				<groupId>com.eg.egsc.component</groupId>
				<artifactId>st-component-rabbitmq</artifactId>
				<version>${component.version}</version>
			</dependency>
			<dependency>
				<groupId>com.eg.egsc.component</groupId>
				<artifactId>st-component-auth</artifactId>
				<version>${component.version}</version>
			</dependency>
			<dependency>
				<groupId>com.eg.egsc.component</groupId>
				<artifactId>st-component-redis</artifactId>
				<version>${component.version}</version>
			</dependency>
			<dependency>
				<groupId>com.eg.egsc.component</groupId>
				<artifactId>st-component-job</artifactId>
				<version>${component.version}</version>
			</dependency>
			<dependency>
				<groupId>com.eg.egsc.component</groupId>
				<artifactId>st-component-lock</artifactId>
				<version>${component.version}</version>
	        </dependency>
			<dependency>
				<groupId>com.eg.egsc.framework</groupId>
				<artifactId>st-framework-service</artifactId>
				<version>${framework.version}</version>
			</dependency>
			<dependency>
				<groupId>com.eg.egsc.framework</groupId>
				<artifactId>st-framework-dao</artifactId>
				<version>${framework.version}</version>
			</dependency>
			
			<dependency>
	            <groupId>com.eg.egsc.framework</groupId>
	            <artifactId>st-starnetwork-job-core</artifactId>
	            <version>${framework.version}</version>
	        </dependency>

			<!-- spring cloud -->
			<dependency>
				<groupId>org.springframework.cloud</groupId>
				<artifactId>spring-cloud-dependencies</artifactId>
				<version>${spring-cloud.version}</version>
				<type>pom</type>
				<scope>import</scope>
			</dependency>

			<!-- postgresql -->
			<dependency>
				<groupId>org.postgresql</groupId>
				<artifactId>postgresql</artifactId>
				<version>${postgresql.driver.version}</version>
			</dependency>

			<!-- mybatis -->
			<dependency>
				<groupId>com.baomidou</groupId>
				<artifactId>mybatisplus-spring-boot-starter</artifactId>
				<version>${mybatisplus-spring-boot-starter.version}</version>
			</dependency>
			
			<!--druid starter-->
			<dependency>
				<groupId>com.alibaba</groupId>
				<artifactId>druid-spring-boot-starter</artifactId>
				<version>${druid-spring-boot-starter.version}</version>
			</dependency>

			<!-- commons -->
			<dependency>
				<groupId>org.apache.commons</groupId>
				<artifactId>commons-lang3</artifactId>
				<version>${commons-lang3.version}</version>
			</dependency>
			<dependency>
				<groupId>com.google.guava</groupId>
				<artifactId>guava</artifactId>
				<version>${guava.version}</version>
			</dependency>

			<!-- swagger -->
			<dependency>
				<groupId>io.springfox</groupId>
				<artifactId>springfox-swagger2</artifactId>
				<version>${swagger2.version}</version>
			</dependency>
			<dependency>
				<groupId>io.springfox</groupId>
				<artifactId>springfox-swagger-ui</artifactId>
				<version>${swagger2.version}</version>
			</dependency>
			<dependency>
				<groupId>javax.validation</groupId>
				<artifactId>validation-api</artifactId>
				<version>${validation.api..version}</version>
			</dependency>

			<dependency>
				<groupId>com.eg.egsc.framework</groupId>
				<artifactId>st-spring-boot-starter-starnetworkjob</artifactId>				
				<version>${framework.version}</version>
			</dependency>
			
			<dependency>
				<groupId>com.eg.egsc.component</groupId>
				<artifactId>st-component-usercenter</artifactId>
				<version>${component.version}</version>
	        </dependency>
		</dependencies>
```

### st-framework-client

Api Client 基础类。

#### 包目录结构

- com
  - eg
    - egsc
      - framework
        - client
          - core
            - BaseApiClient.java
          - dto
          - mq
          - util
        - logservice
          - dto
        - logwhitelist

#### BaseApiClient class

```Java
public abstract class BaseApiClient{}
```

`BaseApiClient` 类作用：

- 初始化 RestTemplate 配置，设置读取时延和连接时延
- 获取用于访问服务的 RestTemplate 客户端
- 设置服务地址
- 设置获取认证
- 根据有上下文的 url 地址和排除的 url 服务主机地址获取完全的 url 地址。
- 提供发送 HTTP POST 请求的 post 方法。

使用 `RestTemplate` 作为 HTTP 请求客户端，定义了 `RequestDto` 和 `ResponseDto` 格式。定义了默认 Kafka 消息发送器 `BaseDefaultKafkaSender`。定义了基础事务传输对象 `BaseBusinessDto`。

### st-framework-dao




#### 包目录结构

- com
  - eg
    - egsc
      - framework
        - dao
          - base
          - intercepter
        - datasource
          - druid
        - paging

#### parent

```XML
<parent>
		<groupId>com.eg.egsc.framework</groupId>
		<artifactId>st-framework</artifactId>
		<version>0.2.0</version>
	</parent>
```

#### 依赖

```XML
<dependencies>
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-web</artifactId>
		</dependency>
		<dependency>
			<groupId>org.postgresql</groupId>
			<artifactId>postgresql</artifactId>
		</dependency>

		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-jdbc</artifactId>
		</dependency>
		<dependency>
			<groupId>org.mybatis.spring.boot</groupId>
			<artifactId>mybatis-spring-boot-starter</artifactId>
			<version>1.3.1</version>
		</dependency>
		<dependency>
			<groupId>com.alibaba</groupId>
			<artifactId>druid-spring-boot-starter</artifactId>
		</dependency>
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-test</artifactId>
			<scope>test</scope>
		</dependency>
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-configuration-processor</artifactId>
			<optional>true</optional>
		</dependency>
		<dependency>
			<groupId>org.apache.commons</groupId>
			<artifactId>commons-lang3</artifactId>
		</dependency>
		<dependency>
			<groupId>commons-beanutils</groupId>
			<artifactId>commons-beanutils</artifactId>
			<exclusions>
				<exclusion>
					<groupId>commons-logging</groupId>
					<artifactId>commons-logging</artifactId>
				</exclusion>
			</exclusions>
		</dependency>
		<dependency>
			<groupId>com.eg.egsc.component</groupId>
			<artifactId>st-component-base</artifactId>
		</dependency>
		<dependency>
			<groupId>com.eg.egsc.component</groupId>
			<artifactId>st-component-auth</artifactId>
		</dependency>
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-actuator</artifactId>
		</dependency>
		<dependency>
			<groupId>com.eg.egsc.component</groupId>
			<artifactId>st-component-log</artifactId>
		</dependency>
	</dependencies>
```

#### BaseDao class

```Java
public abstract class BaseDao<M,M1,E> extends SqlSessionDaoSupport{}
```

BaseDao 类作用：

- 设置 Mapper 类，实体，extMapper 类
- 获取 Mapper 实例
- 获取 ExtMapper 实例

### st-framework-service

#### 目录结构

- com 
  - eg
    - egsc
      - framework
        - service
          - auth
            - adapter
              - dto
            - api
            - config
            - constant
            - exception
            - service
            - web
          - base
            - api
            - web

          - core
            - config
            - info
          - util
            - exception
- messages

#### 主要功能：

- BaseAuthAdapter
    - 用户 Token 认证
    - 用户登陆
    - 更新 Token
    - 删除用户 Token

- AuthenticationAdminApi
    - 处理管理员登陆，使用 JWTUtils 分发 token
    - 将 Token 存储到 redis 缓存
    - 登出操作，从 redis 中删除 token
- AuthenticationService
    - 认证请求
- LoginService
    - 登陆登出
- PermissionService
    - 权限管理
- Swagger 配置
- 通用异常处理

### st-spring-boot-start-starnetworkjob

### st-starnetwork-job-core

## com.eg.egsc.component

### st--component-auth

#### 目录结构

- com
  - eg
    - egsc
      - common
        - component
          - auth
            - adapter
            - config
            - exception
            - model
            - service
            - utils
            - web
              - vo

#### 总结

- 认证，角色，用户，菜单，UI 资源
- JWTUtils token 生成
- EncryptUtil 加密
- 请求忽略
- 资源白名单
- RSAUtils 公匙

### st-component-base

#### 目录结构

- com
  - eg
    - egsc
      - common
        - component
          - i18n
          - utils
        - config
        - constant
        - exception
        - mail
          - impl

#### 总结

主要是一些工具类：

- I18nUtil
- 加密解密
- 货币转换
- 判断集合工具类
- 线程池类
- 日期工具
- Http 请求工具类
- Servlet 工具类，获取浏览器，IP，代理等
- Json 工具类
- JVM 时间工具类
- Logback 日志工具类
- 邮件发送服务

### st-component-job

#### 目录结构

- com
  - eg
    - egsc
      - common
        - component
          - job
            - listener
            - model
            - support
            - util

#### 总结

- 作业管理

### st-component-kafka

- com
  - eg
    - egsc
      - common
        - component
          - kafka
            - dto

#### 总结

- Kafka 配置和话题消息发送
- IOTBusKafka 自动配置属性，发送
- 话题创建

### st-component-lock

分布式锁和 Redis 分布式锁

### st-component-log

日志发送

### st-component-oss

阿里云 OSS 文件上传下载复制删除操作

### st-component-redis

- Redis 配置，健康，属性
- Redis 数据库操作

### st-component-sequence

生成 UUID，获取顺序。

### st-component-usercenter

- 用户手机登陆，登出，注册，重置密码，手机验证码
- 用户属性，更新，修改

## com.eg.egsc.egc.commoncomponent

### egc-st-common-component-service

- 异常处理
- 敏感词处理

### egc-st-common-component

```XML
    <parent>
        <groupId>org.springframework.cloud</groupId>
        <artifactId>spring-cloud-starter-parent</artifactId>
        <version>Edgware.SR2</version>
        <relativePath /> <!-- lookup parent from repository -->
    </parent>
```

#### 依赖

```XML
<dependencies>
            <dependency>
                <groupId>com.eg.egsc.framework</groupId>
                <artifactId>st-framework-service</artifactId>
                <version>${common.framework.version}</version>
            </dependency>
            <dependency>
                <groupId>com.eg.egsc.framework</groupId>
                <artifactId>st-framework-client</artifactId>
                <version>${common.framework.version}</version>
            </dependency>
            <dependency>
                <groupId>com.eg.egsc.framework</groupId>
                <artifactId>st-framework-dao</artifactId>
                <version>${common.framework.version}</version>
            </dependency>

            <dependency>
                <groupId>org.powermock</groupId>
                <artifactId>powermock-module-junit4</artifactId>
                <version>1.7.3</version>
                <scope>test</scope>
            </dependency>
            <dependency>
                <groupId>org.powermock</groupId>
                <artifactId>powermock-api-mockito</artifactId>
                <version>1.7.3</version>
                <scope>test</scope>
            </dependency>
            <dependency>
                <groupId>org.dbunit</groupId>
                <artifactId>dbunit</artifactId>
                <version>2.5.1</version>
            </dependency>
        </dependencies>
```

## com.eg.egsc.egc.mapanalysisapp

### egc-st-mapanalysis-app-client

- POI 相关对象

## com.eg.egsc.mdmcomponent

### st-mdm-component-client

- 获取园区，组织信息

## com.eg.egsc.ordermgmtomponent

### egc-st-ordermgmt-client

枚举定义：

- 设备
- 语言
- 支付状态
- 支付方法
- 支付状态
- 景点地点

#### 功能

- 旅馆房间细节、查询、下单、支付、删除订单
- 订单查询、生成、取消、删除、更新
- 支付
- 剧院座位、订单
- 票务列表、预定、支付、删除


















      