# Queue Interface

```java
package java.util
```

一个保存优先处理元素的集合.

Queue方法总结
*******************************************
|   操作   |   抛出异常   |   返回特殊值    |
|----------| ------------| ---------------|
| Insert   | add(e)      |  offer(e)      |
| Remove   | remove()    |  poll()        |
| Examine  | element()   |  peek()        |
*******************************************

入队(Queue),典型的,但是不是必要的,命令元素以**FIFO**(firs-in-first-out)的方式. 除了优先权队列(Queue)允许元素根据提供的比较富,或者按照元素的自然排序, 和**LIFO** 队列(last-in-first-out)命令元素后进先出.

无论是什么顺序,队列(Queue)的头会被移除当调用remove()或者poll()时. 在**FIFO**队列中,所有新元素被插入到队列末尾. 其它队列(Queue)可能有不同的规则. 每种队列(Queue)的实现必须明确顺序属性.

该接口是 **Java Collections Framework** 的一部分.

```java
public interface Queue<E> extends Collection<E>{
    /**
     * 方法定义
     */
    boolean add(E e);

    boolean offer(E e);

    E remove();

    E poll();

    E element();

    E peek();
}
```
