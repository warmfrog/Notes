# Set interface

```java
package java.util
```

一个不包含重复元素地集合. 更正式的, 集合不包含e1,e2, `e1.equals(e2)`. 正如它的名字暗示的,这个接口模型是一个数学集的抽象.

Set接口添加了另外的规则(stipulations), 除了从Collection接口继承的以外, 例如契约上的所有构造器, 契约上的 add,equals,hasCode方法.为了方便,同样声明了其他继承的方法.

该接口是 Java Collections Framework的一部分.

```java
public interface Set<E> extends Collection<E>{
    int size();

    boolean isEmpty();

    boolean contains(Object o);

    Iterator<E> iterator();

    Object[] toArray[];

    <T> T[] toArray(T[] a);

    boolean add(E e);

    boolean remove(Object o);

    boolean containAll(Collection<?> c);

    boolean addAll(Collection<? extends E> c);

    boolean retainAll(Collection<?> c);

    boolean removeAll(Collection<?> c);

    void clear();

    boolean equals(Object o);

    int hashCode();

    default Spliterator<E> spliterator();
}