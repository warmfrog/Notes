# [JUnit 4][0]

JUnit 是一个写可重复测试的简单框架。它是 xUnit 架构的单元测试框架的一个实例。

* [JavaDoc][2]
* [Get Started][1]

## Usage and Idioms

* [Assertions][3]
* [Test Runners][4]
* [Matchers and assertThat][6]
* [Ignoring a Test][9]
* [Timeout for tests][10]
* [Parameterized Tests][11]
* [Rules][12]
* [Continusous testing][14]

## [Assertions][3]

### 示例

```Java
import static org.hamcrest.CoreMatchers.allOf;
import static org.hamcrest.CoreMatchers.anyOf;
import static org.hamcrest.CoreMatchers.both;
import static org.hamcrest.CoreMatchers.containsString;
import static org.hamcrest.CoreMatchers.equalTo;
import static org.hamcrest.CoreMatchers.everyItem;
import static org.hamcrest.CoreMatchers.hasItems;
import static org.hamcrest.CoreMatchers.not;
import static org.hamcrest.CoreMatchers.sameInstance;
import static org.hamcrest.CoreMatchers.startsWith;
import static org.junit.Assert.assertArrayEquals;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNotSame;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertSame;
import static org.junit.Assert.assertThat;
import static org.junit.Assert.assertTrue;

import java.util.Arrays;

import org.hamcrest.core.CombinableMatcher;
import org.junit.Test;

public class AssertTests {
  @Test
  public void testAssertArrayEquals() {
    byte[] expected = "trial".getBytes();
    byte[] actual = "trial".getBytes();
    assertArrayEquals("failure - byte arrays not same", expected, actual);
  }

  @Test
  public void testAssertEquals() {
    assertEquals("failure - strings are not equal", "text", "text");
  }

  @Test
  public void testAssertFalse() {
    assertFalse("failure - should be false", false);
  }

  @Test
  public void testAssertNotNull() {
    assertNotNull("should not be null", new Object());
  }

  @Test
  public void testAssertNotSame() {
    assertNotSame("should not be same Object", new Object(), new Object());
  }

  @Test
  public void testAssertNull() {
    assertNull("should be null", null);
  }

  @Test
  public void testAssertSame() {
    Integer aNumber = Integer.valueOf(768);
    assertSame("should be same", aNumber, aNumber);
  }

  // JUnit Matchers assertThat
  @Test
  public void testAssertThatBothContainsString() {
    assertThat("albumen", both(containsString("a")).and(containsString("b")));
  }

  @Test
  public void testAssertThatHasItems() {
    assertThat(Arrays.asList("one", "two", "three"), hasItems("one", "three"));
  }

  @Test
  public void testAssertThatEveryItemContainsString() {
    assertThat(Arrays.asList(new String[] { "fun", "ban", "net" }), everyItem(containsString("n")));
  }

  // Core Hamcrest Matchers with assertThat
  @Test
  public void testAssertThatHamcrestCoreMatchers() {
    assertThat("good", allOf(equalTo("good"), startsWith("good")));
    assertThat("good", not(allOf(equalTo("bad"), equalTo("good"))));
    assertThat("good", anyOf(equalTo("bad"), equalTo("good")));
    assertThat(7, not(CombinableMatcher.<Integer> either(equalTo(3)).or(equalTo(4))));
    assertThat(new Object(), not(sameInstance(new Object())));
  }

  @Test
  public void testAssertTrue() {
    assertTrue("failure - should be true", true);
  }
}
```

## [Test Runners][4]

### @RunWith annotation

* [JavaDoc for @Runwith][5]

## [Matchers and assertThat][6]

```Java
assertThat(x, is(3));
assertThat(x, is(not(4)));
assertThat(responseString, either(containsString("color")).or(containsString("colour")));
assertThat(myList, hasItem("3"));
```

更通用的语法：

```Java
assertThat([value], [matcher statement]);
```

这种语法的优点：

* 更易读：允许你根据 主题，动词，对象（assert "x is 3"）而不是 assertEquals。
* 组合： 任何 matcher 语句都可以取反 (not(s)), 组合 (either(s).or(t)), 集合映射 (each(s)), 或者自定义组合 (afterFiveSeconds(s)。

* 更易读的失败消息。
* 自定义 Matchers。通过实现 Matcher 接口。

老的 assert 方法永远不会过时，例如：`assertEquals`,`assertTrue`,等等。
`assertThat` 的第二个参数是一个 Matcher。通过静态导入来包含 Matchers。例如：

```Java
import static org.hamcrest.CoreMatchers.is;
```

或者

```Java
import static org.hamcrest.CoreMatchers.*;
```

* [JUnit Matchers][7]
* [Hamcrest CoreMatchers][8]

## [Ignoring a Test][9]

```Java
@Ignore("Test is ignored as a demonstration")
@Test
public void testSame() {
    assertThat(1, is(1));
}
```

## [Timeout for tests][10]

## [Maven Dependency][13]

## end

[0]: https://junit.org/junit4/
[1]: https://github.com/junit-team/junit4/wiki/Getting-started
[2]: https://junit.org/junit4/javadoc/latest/index.html
[3]: https://github.com/junit-team/junit4/wiki/Assertions
[4]: https://github.com/junit-team/junit4/wiki/Test-runners
[5]: http://junit.org/javadoc/latest/org/junit/runner/RunWith.html
[6]: https://github.com/junit-team/junit4/wiki/Matchers-and-assertthat
[7]: http://junit.org/junit4/javadoc/latest/org/junit/matchers/JUnitMatchers.html
[8]: http://junit.org/junit4/javadoc/latest/org/hamcrest/CoreMatchers.html
[9]: https://github.com/junit-team/junit4/wiki/Ignoring-tests
[10]: https://github.com/junit-team/junit4/wiki/Timeout-for-tests
[11]: https://junit.org/junit4/
[12]: https://github.com/junit-team/junit4/wiki/Rules
[13]: https://github.com/junit-team/junit4/wiki/Use-with-Maven
[14]: https://github.com/junit-team/junit4/wiki/Continuous-testing
