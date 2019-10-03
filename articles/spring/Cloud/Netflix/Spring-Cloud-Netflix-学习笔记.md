# Spring Cloud Netflix

Spring Cloud Netflix 通过自动配置和绑定 Spring 环境和其他 Spring 编程模型风格为 Spring Boot 应用提供了 Netflix OSS 集成。该模式提供了服务发现（Eureka），熔断机制（Hystrix），智能路由（Zuul）和客户端方面的负载均衡（Ribbon）。

## 特点

Spring Cloud Netflix 特点：

- 服务发现：Eureka 实例可以被注册，客户端可以通过 Spring 管理的 bean 发现示例。
- 服务发现：一个嵌入式的 Eureka 服务器可以通过声明式的 Java 配置创建。
- 熔断机制（Circuit Breaker）：Hystrix 客户端可以通过简单的标记驱动的方法装饰创建
- 熔断机制（Circuit Breaker）：声明式的 Java 配置的嵌入式 Hystrix 仪表盘。
- 声明式的 REST 客户端：Feign 创建一个动态的由 JAX-RS 或者 Spring MVC 标记装饰的接口的动态实现。
- 客户端面的负载均衡：Ribbon
- 外部配置：从 Spring 环境到 Archaius 的桥梁（允许使用 Spring Boot 管理的原生 Netflix 组件配置）。
- 路由和过滤：Zuul 过滤的自动注册，一个来颠倒协议创建的配置方法的简单惯例。

## 开始

只要 Spring Cloud Netflix 和 Eureka Core 在任意的有 `@EnableEurekaClient` 标记的 Spring Boot 应用的类路径，就会试图尝试联系位于 <http://localhost:8761> 的 Eureka 服务器（`eureka.client.serviceUrl.defaultZone 的默认值）。

```Java
@SpringBootApplication
@EnableEurekaClient
@RestController
public class Application {

  @RequestMapping("/")
  public String home() {
    return "Hello World";
  }

  public static void main(String[] args) {
    SpringApplication.run(Application.class, args);
  }

}
```

为了运行自己的服务器，需要添加 `spring-cloud-starter-netflix-eureka-server` 依赖和 `@EnableEurekaServer` 标记。

## Spring Cloud Netflix [Reference]([0]

### 服务发现：Eureka Clients

服务发现是一个基于微服务架构的关键原则。试图手动配置每个客户端或者一些传统形式可能会有些困难和脆弱。`Eureka` 是 Netflix 服务发现服务器和客户端。服务器可以被配置和部署为具有高可获得性，服务器之间复制关于已注册的服务的状态。

#### 怎样包含 `Eureka` 客户端

为了包含 `Eureka` 客户端到你的项目，使用 group ID 为 `org.springframework.cloud` 和 artifact ID 为 `spring-cloud-starter-netflix-eureka-client`。

#### 使用 `Eureka` 注册

当一个客户端注册 `Eureka`, 它提供了它自身的元数据 —— 例如主机，端口，健康指示器地址，主页，和其他细节。`Eureka` 从属于每个服务的示例获取心跳消息。如果心跳在一个配置的时间表内失败，这个实例通常会被从注册中心删除。

下面的例子显示了一个最小的 `Eureka` 客户端应用：

```Java
@SpringBootApplication
@RestController
public class Application {

    @RequestMapping("/")
    public String home() {
        return "Hello world";
    }

    public static void main(String[] args) {
        new SpringApplicationBuilder(Application.class).web(true).run(args);
    }

}
```

注意之前的示例显示了一个正常的 Spring Boot 应用。通过将 `spring-cloud-starter-netflix-eureka-client` 包含到类路径，你的应用会自动向 `Eureka` 服务器注册。配置需要定位 `Eureka` 服务器，入下例所示：

```yml
eureka:
  client:
    serviceUrl:
      defaultZone: http://localhost:8761/eureka/
```

默认应用名，虚拟主机和非安全端口是 `${spring.application.name}`,`${spring.application.name}` 和 `${server.port}`。

类路径中有 `spring-cloud-starter-netflix-eureka-client` 将使应用变成一个 Eureka “实例”（它注册它自己）和一个 “客户端”（它可以查询和注册来定位其他服务）。实例的行为由 `eureka.instance.*` 配置对驱动。

查看 `[EurekaInstanceConfigBean][1]` 和 `[EurekaClientConfigBean][2]` 查看很多配置选项的细节。

为了禁止 `Eureka` 服务发现客户端，你可以设置 `eureka.client.enabled` 为 `false`。

#### 使用 `Eureka` 服务器认证

如果你的 `eureka.client.serviceUrl.defaultZone` 地址有凭证嵌入（curl 风格，例如 <https://user:password@localhost:8761/eureka>）,HTTP 基础认证自动添加到你的 `eureka` 客户端。

#### 状态页和健康指示器

`Eureka` 实例默认的状态页和健康指示器是 `/info` 和 `/health`，在 Spring Boot Actuator 应用中是默认的，你需要改变这些。下例显示了这两个设置的默认值：

```yml
eureka:
  instance:
    statusPageUrlPath: ${server.servletPath}/info
    healthCheckUrlPath: ${server.servletPath}/health
```

### 服务发现：Eureka 服务器

#### 怎样包含一个 `Eureka` 服务器

为了在你的项目中包含 `Eureka` 服务器，使用 group ID 为 `org.springframework.cloud` 和 artifact ID 为 `spring-cloud-starter-netflix-eureka-server` 的启动器。

#### 如何运行一个 `Eureka` 服务器

下例展示了一个最小的 `Eureka` 服务器：

```Java
@SpringBootApplication
@EnableEurekaServer
public class Application {

    public static void main(String[] args) {
        new SpringApplicationBuilder(Application.class).web(true).run(args);
    }

}
```

### 熔断机制：Hystrix 的 Spring Cloud Circuit Breaker

Netflix 创建了一个库叫做 `Hystrix` 实现了 `circuit breaker(熔断机制)`模式。在一个微服务架构中，有多层服务调用很常见，如下例所示：

一个低层服务失败可能造成所有到用户的级联失败。当调用一个服务超过 `circuitBreaker.requestVolumeThreshold` (默认：20 requests)，失败占比在一个滚动窗口超过 `metrics.rollingStats.timeInMilliseconds` （默认：10秒） 的定义超过 `circuitBreaker.errorThresholdPercentage` (默认：>50%)，circuit 断开，调用不再做出。为了防止错误和断开的 circuit，开发者需要提供 fallback。

![Hystirx Fallback](images/HystrixFallback.png)

#### 如何包含 Hystrix

为了在你的项目中包含 Hystrix，使用 group ID 为 `org.pringframework.cloud` 和 artifact ID 为 `spring-cloud-starter-netflix-hystrix`。

下面的例子显示了一个最小的 Eureka 服务器和一个 Hystrix circuit breaker:

```Java
@SpringBootApplication
@EnableCircuitBreaker
public class Application {

    public static void main(String[] args) {
        new SpringApplicationBuilder(Application.class).web(true).run(args);
    }

}

@Component
public class StoreIntegration {

    @HystrixCommand(fallbackMethod = "defaultStores")
    public Object getStores(Map<String, Object> parameters) {
        //do stuff that might fail
    }

    public Object defaultStores(Map<String, Object> parameters) {
        return /* something useful */;
    }
}
```

### 客户端方面的负载均衡器：Ribbon

Ribbon 是一个客户端方面的负载均衡器，给了你 HTTP 和 TCP 客户段行为方面的很多控制。Feign 已经用了 Ribblon，所以如果你用 `@FeignClient`，这一节已经应用了。

`Ribbon` 的中心概念是命名的客户端。

### 路由和过滤： Zuul

路由是微服务架构的不可或缺的部分，例如，`/` 可能映射到你的 web 应用，`/api/users` 映射到用户服务，`/api/shop` 映射到 shop 服务。[Zuul][3] 是一个基于 JVM 的路由和 Netflix 的服务端的负载均衡器。

Netflix 使用 Zuul 做以下用途：






[0]: https://cloud.spring.io/spring-cloud-netflix/reference/html/
[1]: https://github.com/spring-cloud/spring-cloud-netflix/tree/$%7Bgithub-tag%7D/spring-cloud-netflix-eureka-client/src/main/java/org/springframework/cloud/netflix/eureka/EurekaInstanceConfigBean.java
[2]: 
https://github.com/spring-cloud/spring-cloud-netflix/tree/$%7Bgithub-tag%7D/spring-cloud-netflix-eureka-client/src/main/java/org/springframework/cloud/netflix/eureka/EurekaClientConfigBean.java
[3]: https://github.com/Netflix/zuul