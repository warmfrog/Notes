# LinkedList

List 和 Deque 接口的双向链表实现. 实现了所有可选的列表操作, 允许所有的元素.

所有的操作执行表现可以被期待为双向链表. 

注意这个实现不是同步的. 可以使用 Collections.synchronizedList方法同步,最好在创建时进行

    List list = Collections.synchronizedList(new LinkedList(...));

```java
public class LinkedList<E> extends AbstractSequentialList<E> implements
                                List<E>, Deque<E>, Cloneable, java.io.Serializable{

/**
 * 成员变量
 */
transient int size=0;
transient Node<E> first;
transient Node<E> last;

// 未显式定义,继承自 AbstractList
protected transient int modCount = 0;


/**
 * 公共方法
 */
public E getFirst();

public E getLast();

public E removeFirst();

public E removeLast();

public void addFirst(E e);

public void addLast(E e);

public boolean contains(Object o);

public int size();

public boolean add(E e);

public boolean remove(Object o);

public boolean addAll(Collection<? extends E> c);

public boolean addAll(int index, Collection<? extends E> c);

public void clear();

public E get(int index);

public E set(int index, E element);

public void add(int index, E element);

public E remove(int index);

public int indexOf(Object o);

public int lastIndexOf(Object o);

// 返回头部第一个元素,但不移除
public E peek();

// 返回第一个元素,不移除
public E element()

// 返回并移除第一个元素
public E poll();

// 移除第一个元素
public boolean remove();

// 添加到最后一个元素
public boolean offer(E e);

// 添加元素到第一个, 双端队列(deque)操作
public boolean offerFirst(E e);

// 插入元素到末尾
public boolean offerLast(E e);

// 提取第一个元素,但不移除
public E peekLast();

// 提取和移除第一个元素
public E pollFirst();

public E pollLast();

public void push(E e);

public E pop();

public boolean removeFirstOccurrence(Object o);

public boolean removeLastOccurrence(Object o);

public ListIterator<E> listIterator(int index);

public Iterator<E> descendingIterator();

public Object clone();

public Object[] toArray();

public <T> T[] toArray(T[] a);

}
```

### 私有内部迭代器类实现

```java
private class ListItr implements ListIterator<E>{

/**
 * 成员变量
 */
private Node<E> lastReturned;
private Node<E> next;
private int nextIndex;
private int expectedModCount = modCount;

/**
 * 共有方法
 */
public boolean hasNext();

public E next();

public boolean hasPrevious();

public E previous();

public int nextIndex();

public int previousIndex();

public void remove();

public void set(E e);

public void add(E e);

public void forEachRemaining(Consumer<? super E> action);

}
```

### 内部节点类实现

```java
private static class Node<E>{
E item;
Node<E> next;
Node<E> prev;

// 构造函数
Node(Node<E> prev, E element, Node<E> next);
}
```

### 私有内部类降序迭代器

```java
private class DescendingIterator implements Iterator<E>{
}
```