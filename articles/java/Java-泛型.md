# 泛型

泛型(generic)是指参数化类型的能力.可以定义带泛型类型的类或方法,随后编译器会用具体的类型替代它.列如,可以定义一个泛型栈类,它存储的是泛型元素.可以从这个泛型类生成一个包含字符串的栈对象和一个包含数字的栈对象.这里,字符串和数字都是替换泛型的具体类型.

使用泛型的主要优点是在编译时而不是在运行时检测出错误.

从JDK1.5开始,Java允许定义泛型类,泛型接口和泛型方法.

```java
package java.lang;

public interface Comparable<T>{
    public int compareTo(T o)
}
```

这里的`<T>`表示形式泛型类型(formal generic type). 随后可以用一个实际具体类型(actual concrete type)来替换它. 替换泛型类型称为泛型实例化(个呢日常instantiation). 按照惯例,像
E 或 T 这样的大写字母用于表示一个形式泛型类型.

泛型类型必须是引用类型.

可以将泛型指定为另外一种类型的子类型.这样的泛型类型成为受限的(bounded).非受限泛型类型
`<E>` 和 `<E extends Object>` 是一样的.

为了定义一个泛型类型,需要将泛型类型凡在类名之后,例如, `GenericStack<E>`.
为了定义一个方法泛型,需要将泛型类型放在方法返回类型之前. 例如 `<E> void max(E o1, E o2)`.

## 原始类型

可以使用泛型类而无需指定具体类型.如: `GenericStack stack = new GenericStack();` 它大体
等同于下列语句.

`GenericStack<Object> stack = new GenericStack<Object>();`

像GenericStack 和ArrayList这样的不使用类型参数的泛型类型成为原始类型(raw type).

```java
public class Max{
    public static Comparable max(Comparable o1, Comparable o2){
        if(o1.compareTo(o2) > 0)
            return o1;
        else
            return o2;
    }
}
```

Comparable o1 和 Comparable o2 都是原始类型声明,原始类型是不安全的.如 `Max.max("Welcome",23);`, 这会引起运行时异常.

一个更好的方法是使用泛型类型.

```java
public class Max1{
    public static<E extends Comparable<E>> E max(E o1, E o2){
        if(o1.compareTo(o2) > 0)
            return o1;
        else
            return o2;
    }
}
```

## 通配泛型

```java
public class WildCardDemo1{
    public static void main(String[]args){
        GenericStack<Integer> intStack = new GenericStack<Integer>();
        intStack.push(1);
        intStack.push(2);
        intStack.push(-2);

        System.out.print("The max number is " + max(intStack));
    }

    public static double max(GenericStack<Number> stack){
        double max = stack.pop().doubleValue();

        while(!stack.isEmpty()){
            double value = stack.pop().doubleValue();
            if(value > max)
                max = value;
        }
        return max;
    }
}
```

上述会出现编译错误, 因为intStack 不是`GenericStack<Number>` 的实例.

尽管Integer 是Number 的子类型,但是 `GenericStack<Integer>` 不是 `GenericStack<Number>`的子类型. 为了避免这个问题,可以使用**通配泛型**.

**通配泛型** 有三种形式: `?`, `? extends T`, `? super T`.

`?` 称为非受限通配(ubbounded wildcard), 它和 `? extends Object` 是一样的.
`? extends T`称为受限通配(bounded wildcard), 它表示T 或 T 的一个未知子类型.
`? super T` 称为下限通配(lower-bound wildcard), 表示T或T的一个未知父类型.

```java
public static double max(GenericStack<? extends Nuber> stack)
```
