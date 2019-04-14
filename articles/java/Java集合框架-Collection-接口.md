# Colleciton interface

集合层级的根接口.一个集合表示一组对象. 一些集合允许重复元素,一些不允许. 一些时有序的,一些是无序的. JDK不提供这些接口实现的明确指引: 它提供了更多子接口的实现: Set, List. 这些接口典型的用来传递集合,操纵它们, 想要的效果是最大通用性.

Bags 或者 multisets( 无序集合可能包含重复元素) 应该直接实现这个接口.

所有通用目的的集合实现类典型地实现了Colleciton间接的通过它的子接口应该提供标准地构造器: 无参构造器: 用来创建一个空集合, 一个参数地构造器: 用来创建和参数元素一样地集合. 效果上,后者构造器允许用户复制任何集合,产生想要地实现类型地等同集合.没有办法强制惯例(convention)(接口不能包含构造器),但是java平台库中所有通用目的地集合都遵守了这一惯例.

毁灭性地(destructive)方法包含在这个接口中, 就是修改它们所操作地集合, 会明确地抛出异常 `UnsupprtedOperationException` 如果该集合不支持该操作.

一些集合实现可能对它们包含地元素有约束. 例如,一些实现阻止空元素,一些对元素类型有约束.

每个集合地同步策略取决于集合自己. 如果实现的强保证空缺,未定义的行为可能使任何方法的调用都会被其他线程修改;这包括直接调用, 将集合传递给一个方法可能发生调用, 使用一个已存在的iterator审查集合.

很多集合框架接口中的方法被定义根据 Object.equals(Object 0) 方法. 例如, contains(Object o): return true 只有 (o==null ? e==null : o.equals(e)).

这个接口是Java Collections Framenwork 的一个成员

声明: 方法的默认实现没有应用同步协议. 如果一个实现明确了同步协议,它必须重载默认实现使用那个协议.

```java
public interface Collection<E> extends Iterable<E>{
/**
 * 成员方法
 */
int size();

boolean isEmpty();

boolean contains(Object o);

@Notnull Iterator<E> iterator();

@NotNUll Object[] toArray();

@NotNull <T> T[] toArray(T[] a);

boolean add(E e);

boolean remove(Object o);

boolean containsAll(Collection<?> c);

boolean addAll(Collections(? extends E> c));

boolean removeAll(Collections<?> c);

    default boolean removeIf(Predicate<? super E> filter) {
        Objects.requireNonNull(filter);
        boolean removed = false;
        final Iterator<E> each = iterator();
        while (each.hasNext()) {
            if (filter.test(each.next())) {
                each.remove();
                removed = true;
            }
        }
        return removed;
    }

boolean retainAll(Collection<?> c);

void clear();

boolean equals(Object o);

int hashCode();

default Spliterator<E> spliterator() {
        return Spliterators.spliterator(this, 0);
    }

default Stream<E> stream();

default Stream<E> parallelStream(); 

}
```