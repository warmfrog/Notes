# java List interface

一个有序集合. 接口的用户可以精确的控制列表上每个元素的插入.用户可以进入每个元素通过它们的整数索引,

不像 sets, lists 典型的允许重复的元素. 更正式的说, lists 典型的允许成对的元素e1, e2, `e1.equals(e1)`, 同样允许多个空值null. 尝试实现一个不重复的列表是无法令人信服的.

List 接口加了额外的规定(stipulation), 除了集合接口中明确的以外. 在 iterator 的契约上, 增加了 add,remove, equal, hasCode方法. 为了简便,其他继承的方法也包含在这里.

List接口提供了根据位置访问列表元素的4个方法. Lists 是基于0的. 在某些实现中(LinkedList)注意这些操作可能时间根据索引成比例的增加. 典型的, 在元素中迭代元素比索引更可取, 当调用者不知道它的实现时.

List接口提供了两个方法搜索特定对象. 从性能考虑,这些方法应该谨慎的使用. 在很多实现中,它们会花费线性时间执行.

注意: 由于 lists 允许包含它们自己作为元素, 极其小心: equals 和 hashCode 方法在这样一个列表中定义地没那么好.

一些列表实现可能对它们包含地元素有约束. 例如, 一些实现禁止空值元素, 一些对元素地类型有约束. 尝试添加一个不合格(ineligible)地元素会抛出一个 unchecked 异常, 通常是 `NullPointerException` , `ClassCastException`. 尝试查询不合格元素地存在性会抛出异常, 或者简单地返回 false; 一些实现可能有表现出前者地行为或者后者的行为.

List 接口时Java 集合框架的一部分.

```java
public interface List<E> extends Collection<E>{
/**
 * 成员方法
 */
int size();

boolean isEmpty();

boolean contains(Object o);

@NotNull Iterator<E> iterator();

@NotNull Object[] toArray();

@NotNull <T> T[] toArray(T[] a);

boolean add(E e);

boolean remove(Object o);

boolean containsAll(Collecition<?> c);

boolean addAll(Collection <? extends E> c);

boolean addAll(int index, Collection<? extends E> c);

boolean removeAll(Collection<?> c);

boolean retainAll(Collection<?> c);

default void replaceAll(UnaryOperator<E> operator);

default void sort(Comparator<? super E> c) {
    Object[] a = this.toArray();
    Arrays.sort(a, (Comparator) c);
    ListIterator<E> i = this.listIterator();
    for (Object e : a) {
        i.next();
        i.set((E) e);
    }
}

void clear();

boolean equals(Object o);

int hashCode();

E get(int index);

E set(int index, E element);

void add(int index, E element);

E remove(int index);

int indexOf(Object o);

int lastIndexOf(Object o);

ListIterator<E> lstIterator();

ListIterator<E> listIterator(int index);

List<E> subList<int fromIndex, int toIndex);

default Spliterator<E> spliterator();

}
```