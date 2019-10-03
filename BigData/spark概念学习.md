


## [spark](https://spark.apache.org/docs/latest/rdd-programming-guide.html) 概念学习

Apache Spark 是一个快速通用的族计算系统。它为Java, Scala, Python, R 提供了高层次的API, 并且提供了一个优化的引擎来支持通用图计算。

## Quick Start

## [RDD Programming Guide](https://spark.apache.org/docs/latest/rdd-programming-guide.html)

为了用 Java 编写spark应用 ，需要添加以下maven 依赖

    groupId = org.apache.spark
    artifactId = spark-core_2.11
    version = 2.4.0

如果要进入HDFS 族， 则要添加一下依赖

    groupId = org.apache.hadoop
    artifactId = hadoop-client
    version = <your-hdfs-version>

### Resilient Distributed Datasets (RDDs)

Spark 围绕 RDD 的概念。 RDD 是一个可以平行操作的容错的集合元素。 有两种方式可以创建RDD： 从驱动程序里并行化一个已存在的集合， 或者引用一个外部存储系统的数据集， HDFS， HBase， 或者其他 Hadoop 输入格式的数据源.

### Parallelized Collections

并行化集合通过在你的驱动程序种调用 JavaSparkContext 的 parallelize 方法作用于一个已存在的集合创建。集合中的元素被复制从而组成一个可以被并行操作的分布式数据集。示例如下:

    List<Integer> data = Arrays.asList(1,2,3,4,5);
    JavaRDD<Integer>  distData = sc.parallelize(data);

一旦创建， 该分布式数据集可以被并行操作。例如，我们可以调用 distData.reduce((a,b) -> a + b ) 来加列表中的元素

并行集合的一个重要的参数是切割数据集的分区数。 Spark 会在族上
的每一个分区运行任务。典型的你想要在每个簇上为每个CPU分配2-4个分区。通常，Spark尝试会基于你的簇自动设置分区数量。然而，你也可以通过人工传递第二个参数 sc.parallelize(data,10) 设置它。注意：在代码的某些地方使用数据切片(分区的同义词)来保持向后兼容性。

### 外部数据集

Spark可以从Hadoop支持的任意存储数据源创建分布式数据集，包括你的本地文件系统，HDFS, Cassandra, HBae, Amazon S3, 等等。Spark 支持文本文件，SequenceFiles， 以及其他任何Hadoop 的输入格式。

文本 RDD 可以使用 SparkContext 的 textFile 方法创建。这个方法使用 URI 作为文件参数， (可以是本地文件，或者 hdfs://, s3a://, etc URI) 然后读到一个行的集合中。以下是一次调用:

    JavaRDD<String> distFile = sc.textFile("data.txt");

一旦创建， distFile 可以进行数据集操作。例如，我们可以将所有行的大小都加起来使用 map 和 reduce 操作如下: distFile.map(s-> s.length()).ruduce((a,b) -> a + b).

除了文本文件，Spark 的 Java API 同样支持几个其他的数据格式：

* JavaSparkContext.wholeTextFiles 让你读取一个包含多个文本文件的目录， 返回 （filename， content）的pairs。 相对于 textFile， textFile 只返回每个文件的每行记录。

- 对于序列文件 SequenceFiles， 使用 SparkContext 的 sequenceFile[K, V] 方法， K，V 是文件的key 类型 和值类型。这些应该是 Hadoop Writable 接口的子类， 像 IntWritable 和 Text。

- 对于其他的Hadoop输入格式， 你可以使用 JavaSparkContext.hadoopRDD 方法， 该方法采取任意 JobConf 和输入格式类， key 类 和 value 类。 你也可以使用 JavaSparkContext.newAPIHadoopRDD 为基于新的 MapReduce API（org.apache.hadoop.mapreduced) 的输入格式。

- JavaRDD.saveASObjectFile 和 JavaSparkContext.objectFile 支持保存一个 RDD 用一种简单的格式包含序列化的Java对象。这不像 特定数据元格式像 Avro 那样有效， Avro 提供一种简单的方式保存任意RDD.

### RDD Operations 分布式数据集合的操作

RDDs 支持两种类型的操作: 转换(transformations), 它创建一个新的数据集从一个已存在的集合， 操作(actions), action 在数据集上运行一个计算之后返回给驱动程序一个值. 例如， map 是一个转换，将数据集的每个元素通过一个函数操作，然后返回一个新的 RDD 表示结果。另一方面， reduce 是一个 action 来聚集所有的 RDD 元素 通过使用一些函数的方式，并返回最终的结果给驱动程序。

Spark中所有的转换都是懒惰的， 它们并不立刻计算结果。相反，它们只是记住了应用在数据集上的转换。转换只有在驱动程序需要结果的时候才进行计算。这种设计允许 Spark 更有效的运行。例如，我们可以创建一个数据集通过在一个reduce过程使用map 只返回 reduce 的结果给驱动， 而不是 大量的 mapped 的数据集。

默认，每个转换的 RDD 可能会重新计算在你每次执行action 的时候。然而，你也可以持久化一个 RDD 到内存中使用persist( or cache) 方法， Spark 会在粗上保存 元素 为了你下次查询能够更快的进入。同样有方法支持持久化 RDD 到磁盘，或者在多个节点之间复制。

###  Basics 基础(Java)

    JavaRDD<String> lines = sc.textFile("data.txt");
    JavaRDD<Integer> lineLengths = lines.map(s -> s.length());
    int totalLength = lineLengths.reduce((a,b) -> a + b);

### Passing Functions to Spark

Spark API 为了在簇上运行，严重依赖传递给驱动程序的函数。 在Java中，函数表现为继承了 org.apache.spark.api.java.function 包中接口的类。 有两种方式创建这样的函数：

* 在你自己的类中实现函数接口， 可以通过 匿名(anonymous)内部类或有名类， 传递一个实例给 Spark。

* 使用 lamda 表达式简明的定义实现.

为了简单，大多数指导使用lamda 表达式， 它易于使用相同的API 形成长形式的语句。例如，可以将代码写成下列形式： 

    JavaRDD<String> lines = sc.textFile("data.txt");
    JavaRDD<Integer> lineLengths = line.map(new Function<String, Integer>(){
        public Integer call(String s) {
            return s.length();
        }
    });
    int totalLength = lineLength.reduce(new Function2<Integer, Integer, Integer>((){
        public Integer call(Integer a, Integer b){
            return a + b;
        }
    });

或者笨重的下列方式：

    class GetLength implements Function<String, Integer>{
        public Integer call(String s) { return s.length()(); }
    }
    class Sum implemnets Function2<Integer, Integer, Integer>
    {
        public Integer call(Integer a, Integer b) { return a + b;}
    }

    JavaRDD<String> lines =sc.textFile("data.txt");
    JavaRDD<Integer> lineLengths = lines.map(new GetLength());
    int totalLength = lineLengths.reduce(new Sum());

### 理解簇

Spark 难点之一就是理解跨簇执行代码时候变量和方法的范围和生命周期。RDD 操作可以修改它们范围之外的变量，这通常是造成困惑的来源。在下面的例子中我们看使用一个foreach() 来递增一个计数器，但是在其他操作中相同的问题也会发生。

### Example

考虑下列的 RDD 元素， 表现可能不同，这取决于它们是否运行在相同的 JVM。 一种通常的例子是运行 Spark 在本地模式 对比运行Spark 应用在簇中(例如 spark-submit to YARN)。

    int counter = 0;
    JavaRDD<Integer> rdd = sc.parallelize(data);

    // Wrong: Don't do this!!
    rdd.foreach(x -> count += x);

    println("Counter value: " + counter);

### Local vs. cluster modes 本地模式 对比 簇模式

上述代码的行为是未定义的， 可能不会预期工作。为了执行工作，Spark 将 RDD 作为划分为 *任务*， 每个任务被一个 *执行者* 执行。在计算之前， Spark 计算任务闭包。 闭包是处理器在RDD上执行计算时必须知道的变量和方法(当前是 foreach())。这个闭包被序列化被发送到每个 *执行者*。

发送个每个 *执行者* 的闭包中的变量现在被复制，因此，当 counter 被foreach 函数引用时，它不再是驱动节点上的 counter 了。驱动节点内存中仍然有一个 counter, 但是不再对 *执行者* 可见了。*执行者* 只看见序列化闭包的拷贝。 因此， counter 的最终值仍然是 0， 因为所有对 counter 的操作都引用的是序列化闭包中的值。

在本地模式，有些情况， foreach 函数实际上会在和驱动相同的 JVM 中执行， 并且会引用相同的原始 counter, 实际上将会更新 counter.

为了确保在这些场景上代码预期工作， 应该使用 Accumulator(累加器). 当在簇中跨worker节点执行时，在 Spark 中提供了一个特别的方法来安全更新变量 Accumulator。Accumulator 一节 会讨论更多细节。

通常， 簇构造 像循环或者本地定义方法， 不应该使用可变的全局状态。 Spark 没有定义且不保证闭包外引用可变对象的行为。一些代码可能在本地模式下工作，但在分布式环境下可能不会预期工作。需要使用 Accumulator 作为替代。

### 打印 RDD 元素

另一种常见的错误是尝试使用rdd.foreach(println) 或者 rdd.map(println) 打印RDD中的元素. 在单机模式下，会打印预期结果。 为了在驱动上打印所有的元素，可以使用 collect() 方法首先将RDD 带到驱动节点：
rdd.collect().foreach(println). 这可能造成驱动节点内存用尽，但是，collect() 在单机上获取了整个 RDD；如果你想要打印少量 RDD中的元素，一种更安全的方法是使用take(): rdd.take(100).foreach(println)

### Working with Key-Value Pairs 处理键值对

大多数在RDDs 上的Spark 操作包含对象的任意类型，RDD 上的 key-value pairs 只能获得一些少量特定的操作。最常用的分布式 “shuffle” 操作，例如通过key来聚集或分组。

在 Java中，键值对表示为 Scala标准库中的 scala.Tuple2 类。你可以简单调用 new Tuple2(a,b) 创建一个元组，访问数据域通过 tuple._1() 和 tuple._2().

RDD 键值对表示为 JavaPairRDD 类，你可以构造 JavaPairRDD 从 JavaRDD 使用特定的 map 操作， 像 mapToPair 和 flatMapToPair. JavaPairRDD 将有同样的 标准 RDD 函数和特定的键值对。

例如，下面代码使用 reduceByKey 操作在键值对上来计算一个文件中每行文本出现了多少次：

    JavaRDD<String> lines = sc.textFile("data.txt");
    JavaPairRDD<String, Integer> pairs = lines.mapToPair(s -> new Tuple2(s,1));
    JavaPairRDD<String,Integer> counts = pairs.reduceByKey((a,b) -> a + b);

我们可以使用 counts.sortByKey(), 例如，为了按字母排序，最终 counts.collect() 将结果返回给驱动程序作为对象数组。

### 转换

下面的表格列出了Spark 支持的一些常用的转换操作。

<table>
<tr><th>Transformation</th><th>Meaning</th></tr>
<tbody>
<tr><td>map(func)</td><td>对原来源中的每个元素做func 操作，返回一个新的分布式数据集</td></tr>
<tr><td>filter(func)</td><td>对在原来源上的每个元素做func 判断，如果为True，则添加到要返回的新的数据集上</td></tr>
<tr><td>flatMap(func)</td><td>与map相似，但是每个输入可以被映射到0个或多个输出（所以func 返回一个 Seq 而不是单个 item）</td></tr>
<tr><td>mapPartition(func)</td><td>Similar to map, but runs separately on each partition (block) of the RDD, so func must be of type Iterator<T> => Iterator<U> when running on an RDD of type T. </td></tr>
<tr><td>mapPartitionWithIndex(func)</td><td>Similar to mapPartitions, but also provides func with an integer value representing the index of the partition, so func must be of type (Int, Iterator<T>) => Iterator<U> when running on an RDD of type T. </td></tr>
<tr><td>sample(withReplacement, fraction, seed) </td><td>Sample a fraction fraction of the data, with or without replacement, using a given random number generator seed. </td></tr>
<tr><td>union(otherDataset) </td><td>Return a new dataset that contains the union of the elements in the source dataset and the argument. </td></tr>
<tr><td>intersection(otherDataset) </td><td>Return a new RDD that contains the intersection of elements in the source dataset and the argument. </td></tr>
<tr><td>distinct([numPartitions])) </td><td>Return a new dataset that contains the distinct elements of the source dataset.</td></tr>
<tr><td>groupByKey([numPartitions]) </td><td>When called on a dataset of (K, V) pairs, returns a dataset of (K, Iterable<V>) pairs.
Note: If you are grouping in order to perform an aggregation (such as a sum or average) over each key, using reduceByKey or aggregateByKey will yield much better performance.
Note: By default, the level of parallelism in the output depends on the number of partitions of the parent RDD. You can pass an optional numPartitions argument to set a different number of tasks. </td></tr>
<tr><td>reduceByKey(func, [numPartitions]) </td><td>When called on a dataset of (K, V) pairs, returns a dataset of (K, V) pairs where the values for each key are aggregated using the given reduce function func, which must be of type (V,V) => V. Like in groupByKey, the number of reduce tasks is configurable through an optional second argument. </td></tr>
<tr><td>aggregateByKey(zeroValue)(seqOp, combOp, [numPartitions]) </td><td>When called on a dataset of (K, V) pairs, returns a dataset of (K, U) pairs where the values for each key are aggregated using the given combine functions and a neutral "zero" value. Allows an aggregated value type that is different than the input value type, while avoiding unnecessary allocations. Like in groupByKey, the number of reduce tasks is configurable through an optional second argument. </td></tr>
<tr><td>sortByKey([ascending], [numPartitions]) </td><td>When called on a dataset of (K, V) pairs where K implements Ordered, returns a dataset of (K, V) pairs sorted by keys in ascending or descending order, as specified in the boolean ascending argument.</td></tr>
<tr><td>join(otherDataset, [numPartitions]) </td><td>When called on datasets of type (K, V) and (K, W), returns a dataset of (K, (V, W)) pairs with all pairs of elements for each key. Outer joins are supported through leftOuterJoin, rightOuterJoin, and fullOuterJoin. </td></tr>
<tr><td>cogroup(otherDataset, [numPartitions]) </td><td>When called on datasets of type (K, V) and (K, W), returns a dataset of (K, (Iterable<V>, Iterable<W>)) tuples. This operation is also called groupWith. </td></tr>
<tr><td>cartesian(otherDataset) </td><td>When called on datasets of types T and U, returns a dataset of (T, U) pairs (all pairs of elements). </td></tr>
<tr><td>pipe(command, [envVars]) </td><td>Pipe each partition of the RDD through a shell command, e.g. a Perl or bash script. RDD elements are written to the process's stdin and lines output to its stdout are returned as an RDD of strings. </td></tr>
<tr><td>coalesce(numPartitions) </td><td>Decrease the number of partitions in the RDD to numPartitions. Useful for running operations more efficiently after filtering down a large dataset. </td></tr>
<tr><td>repartition(numPartitions) </td><td>Reshuffle the data in the RDD randomly to create either more or fewer partitions and balance it across them. This always shuffles all data over the network. </td></tr>
<tr><td>repartitionAndSortWithinPartitions(partitioner) </td><td>Repartition the RDD according to the given partitioner and, within each resulting partition, sort records by their keys. This is more efficient than calling repartition and then sorting within each partition because it can push the sorting down into the shuffle machinery. </td></tr>
</tbody>
</table>

### Actions 

下表列出一些Spark支持的常用的 action 操作

<table class="table">
<tr><th>Action</th><th>Meaning</th></tr>
<tr>
  <td> <b>reduce</b>(<i>func</i>) </td>
  <td> Aggregate the elements of the dataset using a function <i>func</i> (which takes two arguments and returns one). The function should be commutative and associative so that it can be computed correctly in parallel. </td>
</tr>
<tr>
  <td> <b>collect</b>() </td>
  <td> Return all the elements of the dataset as an array at the driver program. This is usually useful after a filter or other operation that returns a sufficiently small subset of the data. </td>
</tr>
<tr>
  <td> <b>count</b>() </td>
  <td> Return the number of elements in the dataset. </td>
</tr>
<tr>
  <td> <b>first</b>() </td>
  <td> Return the first element of the dataset (similar to take(1)). </td>
</tr>
<tr>
  <td> <b>take</b>(<i>n</i>) </td>
  <td> Return an array with the first <i>n</i> elements of the dataset. </td>
</tr>
<tr>
  <td> <b>takeSample</b>(<i>withReplacement</i>, <i>num</i>, [<i>seed</i>]) </td>
  <td> Return an array with a random sample of <i>num</i> elements of the dataset, with or without replacement, optionally pre-specifying a random number generator seed.</td>
</tr>
<tr>
  <td> <b>takeOrdered</b>(<i>n</i>, <i>[ordering]</i>) </td>
  <td> Return the first <i>n</i> elements of the RDD using either their natural order or a custom comparator. </td>
</tr>
<tr>
  <td> <b>saveAsTextFile</b>(<i>path</i>) </td>
  <td> Write the elements of the dataset as a text file (or set of text files) in a given directory in the local filesystem, HDFS or any other Hadoop-supported file system. Spark will call toString on each element to convert it to a line of text in the file. </td>
</tr>
<tr>
  <td> <b>saveAsSequenceFile</b>(<i>path</i>) <br /> (Java and Scala) </td>
  <td> Write the elements of the dataset as a Hadoop SequenceFile in a given path in the local filesystem, HDFS or any other Hadoop-supported file system. This is available on RDDs of key-value pairs that implement Hadoop's Writable interface. In Scala, it is also
   available on types that are implicitly convertible to Writable (Spark includes conversions for basic types like Int, Double, String, etc). </td>
</tr>
<tr>
  <td> <b>saveAsObjectFile</b>(<i>path</i>) <br /> (Java and Scala) </td>
  <td> Write the elements of the dataset in a simple format using Java serialization, which can then be loaded using
    <code>SparkContext.objectFile()</code>. </td>
</tr>
<tr>
  <td> <b>countByKey</b>() <a name="CountByLink"></a> </td>
  <td> Only available on RDDs of type (K, V). Returns a hashmap of (K, Int) pairs with the count of each key. </td>
</tr>
<tr>
  <td> <b>foreach</b>(<i>func</i>) </td>
  <td> Run a function <i>func</i> on each element of the dataset. This is usually done for side effects such as updating an <a href="#accumulators">Accumulator</a> or interacting with external storage systems.
  <br /><b>Note</b>: modifying variables other than Accumulators outside of the <code>foreach()</code> may result in undefined behavior. See <a href="#understanding-closures-a-nameclosureslinka">Understanding closures </a> for more details.</td>
</tr>
</table>

### Shuffle operations

Spark特定的操作出发 shuffle 事件。在Spark的机制中，shuffle 是重新分布数据从而跨区形成不同分组。典型的包括跨执行机和机器的复制数据，使 shuffle 操作变得复杂和代价巨大。

### Background

为了弄清在shuffle 操作中发生了什么， 考虑 reduceByKey操作。 reduceByKey 操作生成一个新的RDD 使所有的单 key 的值结合为一个元组 -- key 和reduce 函数的执行结果(对应于key的所有联系的值). 挑战是不是key的所有值都有必要在相同的分区， 甚至在相同的机器，但是他们必须并置来计算结果。

在Spark中，数据在特定地方的特定操作通常不是跨区分布。 在计算中，单个任务会操作单个分区，因此，为了组织
数据让单个 reduceByKey reduce 任务执行，Spark 需要执行 all-to-all 操作。它必须读取为所有的key读取所有分区的所有值，然后为每个key计算最终结果带来跨分区的所有值，这就是 *shuffle*.

虽然新shuffle 的数据在每个分区中元素集合是确定的，所以是分区自己的顺序，而不是元素的顺序。








































