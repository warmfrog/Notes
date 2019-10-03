# Deque Interface

```java
package java.util
```

支持在两端插入的线性集合. deque是双端队列(double ended queue)的缩写, 发音"deck".

该接口是**Java Collections Framework** 的一部分.

```java
public interface Deque<E> extends Queue<E>{
    /**
     * 成员方法
     */

    void addFirst(E e);

    void addLast(E e);

    boolean offerFirst(E e);

    boolean offerLast(E e);

    E removeFirst();

    E removeLast();

    E pollFirst();

    E pollLast();

    E getFirst();

    E getLast();

    E peekFirst();

    E peekLast();

    boolean removeFirstOccurrence(Object o);

    boolean removeLastOccurrence(Object o);

    boolean add(E e);

    boolean offer(E e);

    E remove();

    E poll();

    E element();

    E peek();

    void push(E e);

    E pop();

    /**
     * 集合方法
     */
    boolean remove(Object o);

    boolean contains(Object o);

    public int size();

    Iterator<E> iterator();

    Iterator<E> descendingIterator();
}
```