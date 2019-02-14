


RDD,弹性分布式数据集(Resilient Distrubuted Dataset),是一个容错的，并行的数据结构，可以让用户显示地将数据存储到磁盘和内存中，并控制数据的分区。同事，RDD还提供了一组丰富的操作来操作这些数据，如 map, flatMap, filter 等转换操作，以及count，saveAsTextFile， reduceByKey 等行动操作。

## Spark RDD 创建

1. 用数据集合创建

    val data = Array(1,2,3,4,5,6,7,8,9)
    val distData = sc.parallelize(data,3)

RDD 的一个重要参数是将数据集划分成分片的数量。对每一个分片，Spark会在集群上运行一个对应的任务。典型情况下，集群中的每一个CPU将对应2~4个分片。一般情况下，Spark会通过当前集群的情况自行设定分片数量。也可以传入参数设定。

2. 外部数据源创建

可以通过Hadoop支持的外部数据源(本地文件系统，HDFS，Cassandra, HBase, 亚马逊S3)等建立分布式数据集。Spark 支持文本文件、序列文件及其他任何Hadoop输入格式文件。

通过文本文件创建RDD的方法

    val distFile1 = sc.textFile("data.txt")
    val distFile2 = sc.textFile("hdfs://192.168.1.100:9000/input.txt)
    val distFile3 = sc.textFile("file:/input/data.txt) //本地目录文件

textFile 可以读取多个文件，或者一个文件夹，压缩文件，通配符路径

    textFile("/input/001.txt, /input/002.txt")
    textFile("/input") //读取目录
    textFile("/input/*.txt")
    textFile("/input/*.gz")  

### Spark RDD 转换操作

1. map

    map是对RDD中的每一个元素都执行一个制定的函数来产生一个新的RDD；RDD之间元素的关系是一对一关系。

    val rdd1 = sc.parallelize(1 to 9, 3)
    val rdd2 = rdd1.map(x => x*2)
    rdd2.collect

2. filter

    filter 是对RDD元素进行过滤；返回一个新的数据集，经过func函数后返回值为true的元素组成

    val rdd3 = rdd2.filter(x => x > 10)
    rdd3.collect

3. flatMap

flatMap类似map，但每个输入元素，会被映射为 0 到多个输入元素(因此，func函数返回值是一个seq，而不是单一元素)， RDD 之间的元素是一对多关系

    val rdd4 = rdd3.flatMap(x => x to 20)

4. mapPartitions

mapPartitions 是 map 的一个变种。map的输入函数是应用于RDD中的每个元素；二mapPartitions的输入函数是每个分区的数据，也就是把每个分区中的内容作为整体来处理的。

5. mapPartitionsWithIndex
6. sample
7. union
    union 是将数据合并，返回一个新的数据集
8. intersection

intersection(otherDataset)是数据交集，返回一个新的数据集，包含两个数据集的交集数据

9. distinct

数据去重

10. groupByKey

groupByKey([numTask])是数据分组操作，在一个由(K,V)对组的数据集上调用，返回一个(K,Seq[V])对的数据集。默认情况下，使用8个并行任务进行分组，可以传入num
