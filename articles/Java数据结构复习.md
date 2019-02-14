


## 1. 引论

## 2. 算法分析

算法(algorithm)是为求解一个问题需要遵循的、被清楚指定的简单指令的集合。对于一个问题，一旦某种算法给定并且被确定是正确的，那么重要的一步就是确定该算法将需要多少诸如时间或者空间等资源量的问题。

## 3. 表、栈和队列

### 3.1 抽象数据类型

抽象数据类型(abstract data type,ADT)是带有一组操作的一些对象的集合。

### 3.2 表ADT

我们将处理形如A0,A1,A2,...,An-1的一般的表，表的大小为N。大小为0的特殊的表称为空表。

对于除空表外的任何表，我们说Ai后继Ai-1并称Ai-1前驱Ai。表中的第一个元素是A0，而最后一个元素是An-1.

表ADT上进行的操作集合：(34,12,52,16,12)

* printList
* makeEmpty
* find(52)
* insert(x)
* remove
* findKth
* insert(x,2)
* next
* previous

#### 3.2.1 表的简单数组实现

对于表的所有操作都可以使用数组实现。虽然数组是由固定容量创建的，但是在需要的时候可以用双倍的容量创建一个不同的数组。

```Java
int [] arr = new int[ 10 ];
//扩张数组
int [] newArr = new int [arr.length * 2];
for(int i = 0; i < arr.length; i++)
    newArr[i] = arr[i];
arr = new Arr;
```

数组实现，使得printList以线性时间执行，findKth操作则花费常数时间。不过，插入和删除却潜藏昂贵的开销，这要看插入和删除发生在什么地方。最坏的情况下，在位置0插入，需要将整个数组后移一个位置以空出空间。而删除第一个元素则需要将表中的所有元素前移一个位置，因此这两种操作最坏情况为O(N).平均来看，这两种操作都需要移动表的一半的元素，因此仍然需要线性时间。如果表的操作都发生在表的高端，那就没有元素需要移动，则添加和删除则只花费O(1)时间。

存在许多情况，表的操作是在高端进行插入的，其后只发生对对数组的访问(findKth)。在这种情况下，数组是表的一种恰当的实现。然而，如果发生对表的一些插入和删除操作，特别是在表的前端进行，那么数组就不是一种好的选择。

#### 3.2.2 简单链表

为了避免插入和删除的线性开销，我们需要保证表可以不连续存储，否则表的每个部分都可能需要整体移动。

    A0 -> A1 -> A2 -> A3 -A4 ->

链表由一系列节点组成，这些节点不必在内存中相连。每个节点均含有表元素和包含该元素后继元的节点的链(link).我们称之为next链。最后一个单元的next链引用null.

为了执行printList或find(x),只要从表的第一个节点开始，然后用一些后继的next链遍历该表即可。这种操作显然是线性时间的，和数组实现时一样，不过其中的常数可能会比用数组实现时要大。findKth操作不如数组实现时的效率高；findKth(i)花费O(i)的时间遍历链表而完成。

remove方法可以通修改一个next引用来实现

    A0 -> A1 ---> A2 ->A3 -> A4
           |            ^
           -------------|
    删除A2

insert方法需要使用new操作符从系统中取得一个新节点，此后执行两次引用的调整。

    A0 -> A1 ----------------> A2 ->A3 -> A4
            |                   ^
            ----> x ------------|

我们看到，如果在实践中知道变动将要发生的地方，那么向链表中插入和删除一项不需要移动很多的项，而只涉及常数个节点链的该表。

在表的前端添加和删除第一项的操作不需要移动很多的项，而只涉及常数个节点链的改变。

### 3.3 Java Collections API中的表

#### 3.3.1 Collection 接口

```java
public interface Collection<AnyType> extends Iterable<AnyType>
{
    int size();
    boolean isEmpty();
    void clear();
    boolean contains(AnyType x);
    boolean add(AnyType x);
    java.util.Iterator<AnyType> iterator();
}
```

#### 3.3.2 Iterator 接口

实现Iterable接口的集合必须提供一个成为iterator的方法，该方法返回一个Iterator类型的对象。

```java
public interface Iterator<AnyType>
{
    boolean hasNext();
    AnyType next();
    void remove();
}
```

Iterator接口的思路是，通过iterator方法，每个集合均可创建1并返回给客户一个实现Iteratoror接口的对象，并将当前位置的概念在对象内部存储下来。

每次对next的调用都给出集合的下一项。

当直接使用Iterator时，重要的是要记住一个基本法则：如果对正在被迭代的集合进行结构上的改变，那么迭代器就不再合法。然而，如果迭代器自己调用了它自己的remove方法，那么这个迭代器就是合法的。这是有时候我们更愿意使用迭代器的原因。

#### 3.3.3 List接口、ArrayList类和LinkedList类

List 接口定义

```java
public interface List<AnyType> extends Collection<AnyType>
{
    AnyType get(int idx);
    AnyType set(int idx, AnyType newVal);
    void add(int idx, AnyType x);
    void remove(int idx);

    ListIterator<AnyType> listIterator(int pos);
}
```

List ADT有两种流行的实现方式。ArrayList类提供了List ADT的一种可增长数组的实现。使用ArrayList的优点在于，对get和set的调用花费常数时间。其缺点是新项的插入和现有项的删除代价昂贵，除非在ArrayList的末端。LinkedList类提供了List ADT的双链表实现。使用LinkedList的优点在于，新项的插入和现有项的删除均开销很小。这意味着，在表的前端进行添加和删除都是常数时间的操作，由此LinkedList提供了方法addFirst和removeFirst、addFirts、addLast和removeLast、以及getFirst和getLast等以有效的添加、删除和访问表两端的项。使用LinkedList的缺点是它不容易做索引，因此对get的调用是昂贵的，除非调用非常接近表的端点。

#### 3.3.5 ListIterator接口

```java
public interface ListIterator<AnyType> extends Iterator<AnyType>
{
    boolean hasPrevious();
    AnyType previous();

    void add(AnyType x);
    void set(AnyType new Val);
}
```

## 4. 树

## 5. 散列

## 6. 优先散列(堆)

## 7. 排序

我们通过对内部排序的考察将指出：

* 存在几种容易的算法以O(N^2)完成排序，如插入排序
* 有一种算法叫做希尔排序(Sellsort),它变成非常简单，以o(N^2)运行，并在实践中很有效。

* 存在一些稍微复杂的算法均需要omig(N log N)次比较。

### 7.1 预备知识

每个算法都将接受包含一些元素的数组；假设所有的数组位置都包含要被排序的数据。还假设N是传递到排序例程的元素的个数。

被排序的对象属于Comparable类型。因此使用CompareTo方法对输入数据施加相容的排序。除(引用)赋值运算外，这是仅有的允许对输入数据进行的排序的操作。在这些条件下的排序叫做基于比较的排序。在默认的排序没有或不可接受的情况下，我们很容易用Comparator来重写排序算法。

### 7.2 插入排序

#### 7.2.1 算法

最简单的排序算法之一是**插入排序**(insertion sort)。插入排序有N-1趟排序组成。对于p=1到N-1趟，插入排序保证从位置0到位置p上的元素为已排序状态。

![insertSort.png](/img/insert-sort.png)

```java
/**
 * Simple insertion sort
 * @param a an array of Comparable items.
 */
 public static <AnyType extends Comparable<? super AnyType>>
 void insertionSort(AnyType [] a){
     int j;

     for(int p = 1; p < a.length; p++){
         AnyType tmp = a[ p ];
         for(j =  p; j > 0 && tmp.compareTo( a[j-1]) < 0; j--)
            a[j] = a[j - 1];
        a[j] = tmp;
     }
 }
```

### 7.2.2 插入排序的分析

由于嵌套循环的每一个都花费N次迭代，因此插入排序为O(N^2),而且这个界是精确的，因为以反序的输入可以达到这个该界。上述代码中，内循环中，对于p的每个值，元素的比较次数最多为p+1次。因此，对所有的p求和得到总数为

    sum(i=2~N)=2 + 3 + 4 + ... + N = O(N2)

另一方面，如果输入数据已预先排序，那么运行时间为O(N),因为内层for循环的检验总是判定不成立而终止。

### 7.4 希尔排序

希尔排序(Shellsort)通过比较相据一定间隔的元素来工作；各趟比较所用的距离随着算法的进行而减少，直到只比较相邻元素的最后一趟排序为止。由于这个原因，希尔排序有时也叫做缩减增量排序(diminishing increment sort).

希尔排序使用一个序列h1,h2,...hi,叫做增量序列(increment sequence)。只要h1=1，任何增量序列都是可行的，不过有些增量序列比另外一些增量序列更好。在使用增量hk的一趟排序之后，对于每一个i我们都有a[i]<=a[i+hk] (此时该不等式是有意义的);所有相隔hk的元素都被排序。此时称文件是hk排序的。

希尔排序的一个重要性质是，一个hk排序的文件(然后是h(k-1)排序的)保持它的hk排序性。

![shell-sort.png](/img/shell-sort.png)

```java 
/**
 * Shellsort, using Shell's (poor) increments.
 * @ param a an array of Comparable items.
 */
 public static <AnyType extends Comparable<? super AnyType>>
 void shellsort(AnyType [] a){
     int j;

     for(int gap = a.length / 2; gap > 0; gap /=2)
        for(int i= gap; i < a.length; i++){
            AnyType tmp = a[i];
            for(j = i; j >= gap && tmp.compareTo(a[j -gap]) < 0; j-=gap)
                a[j] = a[j - gap ];
            a[j] = tmp;
        }
 }
```

### 7.5 堆排序

优先队列可以用于以O(N log N)时间的排序。基于该思想的算法叫做堆排序(heapsort).

### 7.6 归并排序

归并排序是以O(N log N)最坏情形时间运行，而所使用的比较次数几乎是最优的。

### 7.7 快速排序

它的平均运行时间是O(N log N),最坏情形性能为O(N2)