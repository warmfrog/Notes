# 树

一棵树是一些节点的集合.这个集合可以是空集;若不是空集,则树由称作根的节点 r 以及 0个或多个非空的子树T1,T2,...,Tk 组成. 
这些子树的每一棵都被来自根 r 的一条有向边所连接.

从节点n1 到 nk的路径定义为节点 n1,n2,...,nk的一个序列,使得节点 ni 是 ni+1的父亲. 这条路径的长是这条路径边的条数,即 k-1.

对任意节点 ni, ni的深度为从根到ni的唯一路径的长. 因此,根的深度为0,高度为ni到页节点的最长路径.所有页节点的高度都是0.

## 二叉树

二叉树是一颗树,其中每个节点都不能有多于两个的儿子.

二叉树的一个性质是一颗平均二叉树的深度要比节点个数N小的多.平均深度为O(sqrt(N)).而对于二叉查找树(binary search tree),其深度的平均值为 O(log N).

### 实现

因为一个二叉树节点最多有两个子节点,所以我们可以保存直接链接到他们的链.树节点的声明类似于双链表的声明.

```java
class BinaryNode{
    Object element;
    BinaryNode left;
    BinaryNode right;
}
```

### 表达式树

表达式树的树叶是操作数,其它的节点为操作符.

    (a + (b*c)) + (((d*e) + f) * g)

* 中序遍历: 我们可以递归地产生一个带括号的左表达式, 然后打印出在根处的运算发,然后再递归地产生一个带括号的右表达式 而得到一个中缀表达式. 这种一般的方法称为中序遍历.

* 后续遍历: 递归地打印出左子树,右子树,然后打印运算符. 这种编历策略一般称为后续遍历.

    abc*+de*f+g*+

* 先序遍历: 先打印出运算符,然后递归地打印出右子树和左子树. 这种遍历策略为先序遍历.

    ++a*bc*+defg

### 二叉查找树

二叉查找树的一个重要的应用是他们在查找中的应用.

使二叉树成为二叉查找树的性质是: 对于树中的每个节点X,它的左子树中所有项的值小于X中的项,而它的右子树中所有项的值大于X中的项.

二叉查找树要求所有的项都能够排序.

```java
private static class BinaryNode<AnyType>{
    AnyType element;
    BinaryNode<AnyType> left;
    BinaryType<AnyType> right;

    BinaryNode(AnyType theElement){
        this(theElement, null, null);
    }

    BinaryNode(AnyType theElement, BinaryNode<AnyType> lt, BinaryNode<AnyType> rt){
        element = the Element;
        left = lt;
        right = rt;
    }
}
```

```java
public class BinarySearchTree<AnyType extends Comparable<? super AnyType>>{
    private static class BinaryNode<AnyType>{}

    private BinaryNode<AnyType> root;

    public BinarySearchTree(){
        root = null;
    }

    public void makeEmpty(){
        root = null;
    }

    public boolean isEmpty(){
        return root == null;
    }

    public boolean contains(AnyType x){
        return contains(x, root);
    }

    public AnyType findMin(){
        if(isEmpty()) throw new UnderflowException();
        return findMin(root).element;
    }

    public AnyType findMax(){
        if(isEmpty()) throw new UnderflowException();
        return findMax(root).element;
    }

    public void insert(AnyType x){
        root = insert(x, root);
    }

    public void remove(AnyType x){
        root = remove(x, root);
    }

    public void printTree(){

    }

    private boolean contains(AnyType x, BinaryNode<AnyType> t){

    }

    private BinaryNode<AnyType> findMin(BinaryNode<AnyType> t){

    }

     private BinaryNode<AnyType> findMax(BinaryNode<AnyType> t){

    }

    private BinaryNode<AnyType> insert(AnyType x, BinaryTreeNode<AnyType> t){

    }

      private BinaryNode<AnyType> remove(AnyType x, BinaryTreeNode<AnyType> t){

    }

    private void printTree(BinaryNode<AnyType> t){

    }
}
```

#### contains 方法

* 如果T是空集,返回false.
* 如果T的项为X,返回true.
* 否则,对左右子树递归调用.

```java
private boolean contains(AnyType x, BinaryNode<AnyType> t){
    if(t == null)
        return false;
    
    int compareResult = x.compareTo(t.element);

    if(compareResult < 0)
        return contains(x, t.left);
    else if(compareResult > 0)
        return contains(x, t.right);
    else
        return true;

}
```

#### findMin 和 findMax 方法

为执行findMin,从根开始并且只要有左儿子就向左进行. 终止点就是最小的元素.
findMax与 findMin 相反.

递归的findMin方法

```java
private BinaryNode<AnyType> findMin(BinaryNode<AnyType> t){
    if(t == null)
        return null;
    else if(t.left == null)
        return t;
    return findMin(t.left);
}
```

非递归的findMax方法

```java
private BinaryNode<AnyType> findMax(BinaryNode<AnyType> t){
    if(t!=null)
        while(t.right != null)
            t= t.right;

    return t;
}
```

#### insert 方法

```java
private BinaryNode<AnyType> insert(AnyType x, BinaryNode<AnyType> t){
    if(t == null)
        return new BinaryNode<AnyType>(x, null null);

    int compareResult = x.compareTo(t.element);
    if(compareResult < 0)
        t.left = insert(x, t.left);
    else if(compareResult > 0)
        t.right = insert(x, t.right);
    else
        ;
    return t;
}
```

#### remove 方法

```java
private BinaryNode<AnyType> remove(AnyType x, BinaryNode<AnyType> t){
    if(t == null)
        return t;
    
    int compareResult = x.compareTo(t.element);

    if(compareResult < 0)
        t.left = remove(x, t.left);
    else if(compareResult > 0)
        t.right = remove(x, t.right);
    else if(t.left != null && t.right != null){
        t.element = findMin(t.right).element;
        t.right = remove(t.element, t.right);
    }
    else
        t = (t.left != null) ? t.left : t.right;
    return t;
}
```

### AVL树

#### 树的遍历

* **中序遍历**: 一个中序遍历的一般方法是首先处理左子树,然后是当前的节点,最后处理右子树.

这个算法的有趣部分除它简单外,还在于其总的运行时间是O(N).这是因为在树的每一个节点进行的工作是常数时间.每个节点访问一次,在每个节点检测是否为null,建立两个方法的调用,并println.由于在每个节点的工作花费常数时间以及总共有N个节点,因此运行时间为O(N).

* **后续遍历**: 有时,我们需要先处理两颗子树然后才能处理当前节点,这种一般的遍历顺序叫做后序遍历.

* **先序遍历**: 当前节点在其儿子节点之前处理.

* 层次遍历: 这种用的最少. 在层次遍历中,所有深度为d的节点要在深度为d+1的节点之前进行处理.

## B树


