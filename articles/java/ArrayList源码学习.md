# ArrayList 源码学习

Java 集合都在 `java.util`包中.

```java
/**
 * List接口的可调整大小的数组实现. 实现了所有可选的列表操作, 允许所有的元素,包括null. 除了实现List接口, 这个类同样提供方法操纵用于list内部存储的数组的大小. 这个类大致等同于 Vector, 除了它是未同步的.

 size, isEmpty, get, set, iterator, listIterator 操作在常量时间运行. add 操作以 amortized常量时间运行, 也就是说, 添加 n 个元素花费 O(n) 时间. 所有的其他操作花费线性时间(粗略的讲). 常量因素跟 LinkedList 相比较低.

 每个 ArrayList 实例有一个 capacity. capacity 是数组用于在列表中存储元素的列表. 它总是至少和 list size 大小一样大. 只要元素添加到 ArrayList中, 它的容量就自动增长. 成长政策的细节没有规定 除了添加新的元素花费常量 amortized时间.

 一个应用可以添加 ArrayList 实例的容量大小,在添加很多元素之前调用 ensureCapacity. 这会减少增量重分配的数量.

 注意这个实现不是同步的. 如果多个线程并发访问 ArrayList 实例, 至少其中一个线程修改了list结构, 它必须从外部进行同步. (一个结构化修改是任意操作增加或删除一个或多个元素后,明确的重新调整后端数组的大小; 仅仅设置元素值不是结构化修改). 典型的通过同步一些对象来自然的封装列表.

 如果不存在这样的对象,这个列表应该使用 Collections.synchronizedList 方法来封装. 这最好在创建时间完成, 来阻止未同步的进入列表:
 List list = Collections.synchronizedList(new ArrayList(...));

 类的 {@link #iterator() iterator} 返回的 iterators 和 listIterator 方法是 快速失败的(fail-fast): 如果在返回iterator后, 列表进行了结构化修改, 以任意方式进行了列表的结构修改, 而没有通过 iterator 的 remove() 和 add() 进行, iterator 就会丢出一个异常: ConcurrentModificationException. 因此, 在并发修改中, iterator 快速干脆的失败, 而不是任意的冒险, 在将来无法预测的时间发生无法确定的行为.
*/
```

类定义

```java
public class ArrayList<E> extends AbstractList<E>
        implements List<E>, RandomAccess, Cloneable, java.io.Serializable
        {
            private static final long serialVersionUID = 8683452581122892189L;
            // 默认的初始容量
            private static final int DEFAULT_CAPACITY = 10;

            private int size;
        }
```

### 共有成员方法

```java
/**
 * 将 ArrayList 实例的容量减小到 list的当前大小. 因为默认 capacity是大于等于 list.size的.
 */
public void trimToSize();

public void ensureCapacity(int minCapacity);

public int size();

public boolean isEmpty();

public boolean contains(Object o);

public int indexOf(Object o);

public int lastIndexOf(Object o)

/**
 * 一份 ArrayList 实例的 拷贝
 */
public Object clone();

/**
 * 返回一个数组,包含 List 中的所有元素
 */
public Object[] toArray();

public <T> T[] toArray(T[] a);

pubic E get(int index);

public E set(int idnex. E element);

public boolean add(E e);

public void add(int index, E element);

public E remove(int index);

public boolean remove(Object o);

public void clear();

public boolean addAll(Collection<? extends E> c);

public boolean addAll(int index, Collection<? extends E> c);

protected void removeRange(int fromIndex, int toIndex);

public boolean removeAll(Collection<?> c);

/**
 * 保留集合,移除 c 集合中不存在的元素
 */
public boolean retainAll(Collection<?> c);

@NotNull public ListIterator<E> listIterator(int index);

@NotNull public ListIterator<E> listIterator();

@NotNull public Iterator<E> iterator();

public List<E> subList(int fromIndex, int toIndex);

public void forEach(Consumer<? super E> action);

public Spliterator<E> spliterator();

public boolean removeIf(Predicate<? super E> filter);

public void replaceAll(UnaryOperator<E> operator);

public void sort(Comparator<? super E> c);

```

### 内部类迭代器

```java
private class Itr implements Iterator<E>{
/**
 * 公共成员方法
 */
public boolean hasNext();

/unchecked/
public E next();

public void remove();

public void forEachRemaining(Consumer<? super E> consumer);

}
```

ListIterator

```java
private class ListItr extends Itr implements ListIterator<E>{
/**
 * 公共成员方法
 */
 public boolean hasPrevious();

 public int nextIndex();

 public int previousIndex();

 public E previous();

 public void set(E e);

 public void add(E e);
}
```


