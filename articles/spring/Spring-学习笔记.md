# [Spring](https://spring.io/projects) 学习笔记

[Spring](https://spring.io/projects) 包含很多项目，从配置到安全，web 应用到到大数据。

## 主要项目

-[Spring Boot](https://spring.io/projects/spring-boot)
-[Spring Framework](https://spring.io/projects/spring-framework)
-[Spring Cloud Data Flow](https://spring.io/projects/spring-cloud-dataflow)
-[Spring Cloud](https://spring.io/projects/spring-cloud)
-[Spring Data](https://spring.io/projects/spring-data)
-[Spring Integration](https://spring.io/projects/spring-integration)
-[Spring Batch](https://spring.io/projects/spring-batch)
-[Spring Security](https://spring.io/projects/spring-security)
-[Spring Hateoas](https://spring.io/projects/spring-hateoas)
-[Spring Rest Docs](https://spring.io/projects/spring-restdocs)
-[Spring AMQP](https://projects.spring.io/spring-amqp)
-[Spring Mobile](https://projects.spring.io/spring-mobile)
-[Spring for Android](https://projects.spring.io/spring-android)
-[Spring Web Flow](https://projects.spring.io/spring-webflow)
-[Spring Web Services](https://spring.io/projects/spring-ws)
-[Spring LDAP](https://spring.io/projects/spring-ldap)
-[Spring Session](https://spring.io/projects/spring-session)
-[Spring Shell](https://projects.spring.io/spring-shell)
-[Spring Flo](https://spring.io/projects/spring-flo)
-[Spring Kafka](https://spring.io/projects/spring-kafka)
-[Spring StateMachine](https://projects.spring.io/spring-statemachine)
-[Spring IO platform](https://spring.io/projects/platform)

## Annotation 标记

### *@PostConstruct*

PostConstruct 用在一个方法上，表示依赖注入完成后需要执行的任意初始化过程。即使这个类不需要任何依赖注入，被PostConstruct 标记的方法也必须被调用。一个类中只有一个方法可以被 PostConstruct 标记。

被标记的方法必须满足以下标准：

- 不能有任何参数
- 不能抛出应用异常，但是可以抛出检查异常。
- 被标记的方法不能是静态的。

### *@Value*

Value 标记暗示一个属性或方法参数的默认值，典型的使用方法是”#{systemProperties.myProp}"。标记的实际处理是由 `org.springframework.beans.factory.config.BeanPostProcessor` 完成的。
