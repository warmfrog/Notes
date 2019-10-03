# Map Interface

一个对象将key映射到值. 一个map不能包含重复的键; 每个键可以映射到最多一个值.

这个接口取代了Dictionary类, 一个完全抽象的类.

Map 接口提供了三种集合视图,允许将map内容看作: key的集合, values的集合, 键值对的集合. 一些实现,如TreeMap,保证他们的顺序. 而HashMap不保证.

这个接口是 Java Collections FrameWork 的一部分.

```java
public interface Map<K,V>{
    /**
     * 成员方法
     */

    int size();

    boolean isEmpty();

    boolean containsKey(Object key);

    boolean containsValue(Object value);

    V get(Object key);

    V put(K key, V value);

    V remove(Object key);

    void putAll(Map<? extends K, ? extends V> m);

    void clear();

    Set<K> keySet();

    Collection<V> values();

    Set<Map.Entry<K,V>> entrySet();

    boolean equals(Object o);

    int hashCode();

}
```

### 内部接口 Entry<K,V>

```java
interface Entry<K,V>{
    K getKey();
    V getValue();
    V setValue(V value);
    boolean equals(Object o);
    int hashCode();
    public static <K extends Comparable<? super K>, V> Comparator<Map.Entry<K,V>> comparingByKey();


}
```