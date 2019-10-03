# [Spring Test][0]

测试支持由 2 个模块提供， `spring-boot-test`, `spring-boot-test-autoconfigure`。

大多数开发者使用 “Starter” `spring-boot-starter-test`。它包含了很多库，例如：JUnit，AssertJ，Hamcrest 等等。

## spring-boot-starter-test

`spring-boot-starter-test` 包含了以下库：

* [JUnit4][1]
* [Spring Test][2]
* [AssertJ][3]
* [Hamcrest][4]
* [Mockito][5]
* [JSONassert][6]
* [JsonPath][7]

## 测试 Spring Boot 应用

一个 Spring Boot 应用是一个 Spring `ApplicationContext`。

External properties, logging, and other features of Spring Boot are installed in the context by default only if you use SpringApplication to create it.

Spring Boot 提供了一个 `@SpringBootTest` 标记，作为 `@ContextConfiguration` 的替代。这个标记通过 `SpringApplication` 在你的测试里创建的 `ApplicationContext`。

如果使用 JUnit4 测试，不要忘了加上 `@RunWith(SpringRunner.class)`。

## end

[0]: https://docs.spring.io/spring-boot/docs/current/reference/html/boot-features-testing.html
[1]: https://junit.org/
[2]: https://docs.spring.io/spring/docs/5.1.9.RELEASE/spring-framework-reference/testing.html#integration-testing
[3]: https://joel-costigliola.github.io/assertj/
[4]: https://github.com/hamcrest/JavaHamcrest
[5]: https://mockito.github.io/
[6]: https://github.com/skyscreamer/JSONassert
[7]: https://github.com/jayway/JsonPath
