


## 机器学习

机器学习是数据通过算法构建出模型并对模型进行评估，评估的性能如果达到要求就拿这个模型来测试其他数据，如果达不到要求就要调整算法来重新建立模型，再次进行评估，如此循环反复，最终获得满意的经验来处理其他数据。

1. 监督学习

监督是从给定的训练数据集中学习一个函数(模型)，当新的数据到来时，可以

## [官方文档地址](http://spark.apache.org/docs/latest/ml-guide.html)

MLlib 是Spark 机器学习库。它的目标是使实际的机器学习规模化，简单化。简单讲，它提供了如下工具：

* 机器学习算法(ML Algorithms)：常用的机器学习算法如 聚类(classification), 回归(regression), 聚簇(clustering), 协同过滤(collaborative filtering)
* 特征化(Featurization): 特征提取，转换，降维，选择
* 流水线(Pipelines): 构造，评估，调优(tuning) 机器学习管道(ML Pipelines).
* 持久化(Persistence): 保存和载入算法，模型，和流水线(Pipelines).
* 工具：线性代数，统计，数据处理

## [推荐系统(Recommender system)](https://en.wikipedia.org/wiki/Recommender_system#Collaborative_filtering)

推荐系统典型的通过以下两种方式产生推荐列表：通过[协同过滤](https://en.wikipedia.org/wiki/Collaborative_filtering)或者通过[基于内容的过滤](https://en.wikipedia.org/wiki/Content-based_filtering)(基于个性方法)。[协同过滤](https://en.wikipedia.org/wiki/Collaborative_filtering)从用户过去的行为和其他用户的相同决定构建模型。这个模型用于预测物品或者用户感兴趣的。[基于内容的过滤](https://en.wikipedia.org/wiki/Content-based_filtering)方法利用一系列离散的物品特点来推荐另外拥有相同特点的物品。这些方法通常结合为[混合推荐系统(Hybrid Recommender Systems)](https://en.wikipedia.org/wiki/Recommender_system#Hybrid_recommender_systems).

## 协同滤波(Collaborative filter)

设计一个推荐系统广泛使用的一个方法是协同滤波。协同滤波方法基于收集和分析大量用户的行为，活动，喜好，基于与其他用户的相似度预测用户会的喜好。协同滤波的关键优点是它不依赖于机器分析内容，因此，它有能力精确推荐复杂的物品例如电影而不需要去了解物品本身。在推荐系统中很多算法用来测量用户相似度或者物品相似度。例如，k-nearest neighbor (k-NN)方法和 Allen首先实现的[皮尔森纠正(Pearson Correlation)](https://en.wikipedia.org/wiki/Pearson_correlation).

协同滤波是基于人们过去赞同的未来也会赞同的假设，并且他们会喜欢与他们过去喜欢的物品相似的物品。

当从用户模型构建行为时，一个区别通常是显式的数据收集和隐式的数据收集。

协同滤波著名的例子之一是 item-item的协同滤波， Amazon.com 推荐系统的流行推荐算法。

协同滤波算法一个典型类型是使用[矩阵分解](https://en.wikipedia.org/wiki/Matrix_factorization_(recommender_systems))，一个(低秩矩阵近似](https://en.wikipedia.org/wiki/Low_rank_approximation)的方法。

协同滤波方法是基于内存的分类和基于协同滤波的模型。基于内存方法的一个著名示例是基于用户的算法，基于模型的算法是 [Kernel-Mapping Recommender](https://en.wikipedia.org/wiki/Recommender_system#cite_note-42)。



协同滤波常用于推荐系统。这种技术是为了补充user-item关联矩阵的缺失的入口。spark.mllib目前支持基于模型的协同滤波，用于预测缺失的由一小部分潜在因素描述的用户和产品关系的入口。sparkmllib使用ALS(alternating least squares)(交替最小二乘法)算法来学习这些潜在的因素。spark.mllib的实现拥有下列参数:
jiqi
* numBlocks 是用来并行化计算的块得数量(设置-1自动配置)
* rank 是特点数量(通常被引用作为潜在因子数量)
* iterations 是ALS 算法要运行的迭代次数
* lambda 明确了正则化(regularization)参数
* implicitPrefs 明确是否使用ALS变量的精确的反馈或者使用隐式的反馈数据
* alpha 是可应用的参数暗示用于控制在偏好观察中基线自信ALS的反馈变量

## 显式(Explicit) vs. 隐式反馈(implicit feedback)

基于矩阵分解的协同滤波标准方法user-item矩阵作为具体的偏好，例如，用户给电影的评分。

通常现实世界中使用仅有隐式反馈的样例(视图，点击，购买，喜好，分享等). spark.mllib处理这种数据的方法采纳于隐式数据集的协同滤波(Collaborative Filtering for Implicit Feddback Datasets). 必要的，替代直接试图使用评分矩阵，这种方法将数据看做对用户动作(点击数，用户看电影花费的累计)观察的强度表示.这些数字关系到观察用户偏好的信心水平，而不是对item项显式的评分。这种模型试图找到潜在因子的能够用来预测用户对某个item的预期偏好.

## 正则参数的规模

自v1.1版本，我们在更新用户因子方面使用规模化(scale)正则参数lambda来用由用户生成的评分解决每个最小平方问题,或者更新产品因子的评分。这种方法叫做"ALS-WR"在 “[Netflix Prize 的大规模协同滤波](http://dx.doi.org/10.1007/978-3-540-68880-8_32)”这一章讨论过.它使lamda更少的依赖数据集的规模，因此我们可以使用从样本集中学得的最好参数到全部数据集，并且期待相似的性能。

## 示例

下列实例，载入评分数据。每一行由一个用户，一个产品，一个评分组成。我们使用默认的假定评分为显式的ALS.train()方法。我们通过测量评分预测中的方差(Mean Squared Error)评估推荐模型.

更多细节参考 [ALS Java docs](http://spark.apache.org/docs/2.4.0/api/java/org/apache/spark/mllib/recommendation/ALS.html)

    import scala.Tuple2;
    
    import org.apache.spark.api.java.*;
    import org.apache.spark.mllib.recommendation.ALS;
    import org.apache.spark.mllib.recommendation.MatrixFactorizationModel;
    import org.apache.spark.mllib.recommendation.Rating;
    import org.apache.spark.SparkConf;

    SparkConf conf = new SparkConf().setAppName("Java Coolaborative Filtering Example");
    JavaSparkContext jsc = new JavaSparkContext(conf);

    //load and parse the data
    String path = "data/mllib/als/test.data";
    JavaRDD<String> data = jsc.textFile(path);
    JavaRDD<Rating> ratings = data.map(s -> {
        String[] sarray = s.split(",");
        return new Rating(Integer.parseInt(sarray[0]),
            Integer.parseInt(sarray[1]),
            Double.parseDouble(sarray[2]));
    });

    //Build the recommendation model using ALS
    int rank = 10;
    int numIterations = 10;
    MatrixFactorizationModel model = ALS.train(JavaRDD.toRDD(ratings), rank, numIterations, 0.01);

    //Evaluate the model on rating data
    JavaRDD<Tuple2<Object, Object>> userProducts = rating.map(r -> new Tuple2<>(r.user(), r.product()));
    JavaPairRDD<Tuple2<Integer, Integer>, Double> predictions = JavaPairRDD.fromJavaRDD(
        model.predict(JavaRDD.toRDD(userProducts)).toJavaRDD()
             .map(r -> new Tuple<>(new Tuple2<>(r.user(), r.prodduct()), r.rating()))
        );
    JavaRDD<Tuple2<Double, Double>> rateAndPreds = JavaPairRDD.fromJavaRDD(
        ratings.map(r -> new Tuple2<>(new Tuple2<>(r.user(), r.product()), r.rating()))
        .join(predictions).values();
    double MSE = rateAndPreds.mapToDouble(pair ->{
        double err = pair._1() - pair._2();
        return err * err;
    }).mean();
    System.out.println("mean Squared Error = " + MSE ));

    //save and load model
    model.save(jsc.sc(), "target/tmp/myCollaborativeFilter");
    MatrixFacorizationModel sameModel = MatrixFactorizationModel.load(jsc.sc(),
        "target/tmp/myCollaborativeFilter");



## MLlib 中的聚类和分类

聚类和分类是机器学习中两个常用的算法，聚类将数据分开为不同的集合，分类对新数据进行类别预测。

### 聚类和分类

(1)什么是聚类

聚类(Clustering)是将数据对象分组成多个类或簇(Cluster),它的目标是：在同一个簇中的对象之间具有较高的相似度，不同簇中的对象差别很大。聚类是人们日常生活中的常见行为，“物以类聚，人以群分”,其核心思想在于分组，人们不断改进聚类模式来学习如何区分各个事务和人.

(2)什么是分类

数据仓库、数据库、或其他信息库中有许多可以为商业、科研等活动的决策提供所需要的知识。分类和预测即是其中的两种数据分析形式，可以用来抽取能够描述重要数据集合或预测未来数据趋势。分类方法(Classification)用于预测数据对象的离散类别(Categorical Label)；预测方法(Prediction)用于预测数据对象的连续取值。

    **分类流程**: 新样本->特征选取->分类->评价
    **训练流程**: 训练集->特征选取->训练->分类器

最初，机器学习的分类应用大多是在这些方法及基于内存基础上所构造的算法。目前，数据挖掘方法都要求具有基于外存以处理大规模数据集合能力，同时具有可扩展能力。

### MLlib 中的聚类和分类

MLlib目前已经实现了K-Means聚类算法，朴素贝叶斯和决策树分类算法。

(1) K-Means 算法

K-Means聚类算法能够轻松的对聚类问题建模，并且能够在分布式的环境下运行。

K-Means 聚类算法中的K是聚类的数目，在算法中会强制要求用户数据。如果将新闻聚类成注入政治、经济、文化等大类，可以选择10~20的数字作为K。因为这种顶级类别的数量是很小的。如果要对这些新闻详细分类，选择50~100的数字也是没有问题的。

K-Means聚类算法主要可以分为三步。第一步是为待聚类的点寻找聚类中心；第二部是计算每个点聚类中心的距离，将每个点聚类到离该点最近的聚类中去；第三部是计算聚类中所有点的坐标平均值，并将这个平均值作为新的聚类中心点。反复执行第二部，知道聚类中心不再进行大范围的移动，或者聚类次数达到要求为止。

(2)MLlib 之 K-Means源码解析

MLlib的K-Means的原理是：在同一个数据集上，跑多个K-Means算法(每个成为一个run),然后返回效果最好的那个聚类的类簇中心。初始的类簇中心店的选取有两种方法，一种是随机，另一种是采用KMeans\|\|(KMeans++ 的xianshi法的停止条件是迭代次数达到设置的次数，或者在某一次迭代后所有run的K-Means算法都收敛。

1. 类簇中心初始化

对每个运行的K-Means随机选择K个点作为初始类簇：

    private def initRandom(data: RDD[Array[Double]]): Array[ClusterCenters] = {
        //Sample all the cluster centers in one pass to avoid repeated scans
    val sample = data.takeSample(true, runs * k, new Random().nextInt()).toSeqArray
    .tabulate(runs)(r => sample.slice(r * k, (r + 1).toArray))
    }

2. 计算属于某个类簇的点

在每一次迭代中，首先会计算属于各个类簇的点，然后更新各个类簇的中心

    //K-Means算法的并行实现通过Spark的mapPartitions函数，通过该函数获取到分区的迭代器。可以在每个分区内计算该分区内的点属于哪个类簇，之后对于每个运行算法中的每个类簇计算属于该类簇的点的个数以及累加和。

    val totalContribs = data.mapPartitions { points =>
    val runs = activeCenters.length
    val k = activeCenters(0).length
    val dims = activeCenters(0)(0).length

    val sums = Array.fill(runs, k)(new DoubleMatrix(dims))
    val counts = Array.fill(runs, k)(0L)

    for(point <- points; (centers, runIndex) <- activeCenters.zipWithIndex){
    //找到距离改点最近的聚类中心点
    val (bestCenter, const) = KMeans.findClosest(centers, point)
    //统计该运行算法开销
    costAccum(runIndex) += cost
    //将距离该点最近的类簇的点数量加1，sum.divi(count)就是了I类簇的新中心
    counts(runIndex)(bestCenter) +=1
    }
    
    val contribs = for(i <- until runs; j <- 0 until k) yield{
        ((i,j), (sums(i)(j), counts(i)(j)))
    }
    contribs.iterator
    //对于每个运行算法的每个类簇计算属于该类簇的点的个数和加和
    }.reduceByKey(mergeContribs).collectAsMap()



## [DataFrame-based API is primary API](http://spark.apache.org/docs/latest/mllib-statistics.html)

0, 基于RDD的API在spark.mllib 中现在进入维护状态。现在Spark主要的机器学习API是在spark.ml包中的基于 DataFrame 的API.

## MLlib: RDD-based API

    package spark.mllib

### DataTypes

MLlib支持向量和矩阵存储在单机上，同样支持存储在一个或多个RDD的分布式矩阵。本地向量和本地矩阵是服务于公共接口的简单数据模型。底层的线性代数操作有[Breeze](http://www.scalanlp.org/)提供。

#### 本地向量(Local vector)

本地向量有整数类型的和0为索引开始的和双类型的值，存储在单机上。MLlib支持两种类型的本地向量：稠密和稀疏的。一个稠密向量有一个二位数组支持表示它的入口值，而一个稀疏矩阵由两个并行数组支持：索引和值。例如，一个向量(1.0, 0.0, 3.0)可以被表示为稠密形式[1.0, 0.0, 3.0] 或者稀疏形式(3,[0,2],[1.0,3.0]), 3 是向量大小。

本地向量类是[Vector](http://spark.apache.org/docs/latest/api/java/org/apache/spark/mllib/linalg/Vector.html),我们提供两种实现：[DenseVector](http://spark.apache.org/docs/latest/api/java/org/apache/spark/mllib/linalg/DenseVector.html) 和[SparseVector](http://spark.apache.org/docs/latest/api/java/org/apache/spark/mllib/linalg/SparseVector.html). 我们推荐使用Vectors 中实现的工厂方法创建本地向量，参考[Ｖector Java docs](http://spark.apache.org/docs/latest/api/java/org/apache/spark/mllib/linalg/Vector.html) 和[Vectors Java docs](http://spark.apache.org/docs/latest/api/java/org/apache/spark/mllib/linalg/Vectors.html)查看更多细节。

    import org.apache.spark.mllib.linalg.Vector;
    import org.apache.spark.mllib.linalg.Vectors;

    Vector dv = Vectors.dense(1.0, 0.0, 3.0);
    Vector sv = Vectors.sparse(3, new int[]{0,2}, new double[]{1.0, 3.0});

#### 标签点(Labeled point)

一个标签点是一个本地向量，稀疏的或者稠密的，与一个标签/回复相关联。在ＭLlib中，标签点在有监督的学习算法(supervised learning algorithms)中使用. 我们使用double存储一个标签，如此我们就能在回归(regression)和聚类(classification)中使用标签点了。对于二进制分类，一个标签可能是０或１．对于多分类，标签可能是从０，１，２，３开始的索引。

一个标签点表示为[LabeledPoint](http://spark.apache.org/docs/latest/api/java/org/apache/spark/mllib/regression/LabeledPoint.html)

    import org.apache.spark.mllib.linalg.Vectors;
    import org.apache.spark.mllib.regression.LabeledPoint;

    LabeledPoint pos = new LabeledPoint(1.0, Vectors.dense(1.0, 0.0, 3.0));\
    LabeledPoint neg = new LabeledPoint(0.0, Vectors.sparse(3, new int[]{0,2}, new double[]{1.0, 3.0}));

##### Sparse data

实际中很常见的是拥有稀疏的训练数据。MLlib 支持读取存储为LIBSVM格式的训练示例，　是[LIBSVM](http://www.csie.ntu.edu.tw/~cjlin/libsvm/)　和　[LIBLINEAR](http://www.csie.ntu.edu.tw/~cjlin/liblinear/)　默认的数据格式。它是一种每一个使用如下方式表示稀疏标签特征向量的文本格式。

    label index1:value1 index2:value2

索引以递增的顺序，载入完成后，特征索引被转换为以０作为开始的索引。

[MLUtils.loadLibSVMFile](http://spark.apache.org/docs/latest/api/java/org/apache/spark/mllib/util/MLUtils.html)读取存储为LIBSVM格式的训练示例。

    import org.apache.spark.mllib.regression.LabeledPoint;
    import org.apache.spark.mllib.util.MLUtils;
    import org.apache.spark.api.java.JavaRDD;

    JavaRDD<LabeledPoint> examples = MLUtils.loadLibSVMFile(jsc.sc(), "data/mllib/sample_libsvm_data.txt").toJavaRDD();

#### 本地矩阵

一个本地矩阵是一个有整数类型的行和列索引的双类型值，存储在单机上。ＭL支持稠密矩阵，

本地矩阵的基础类是[Matrix](http://spark.apache.org/docs/latest/api/java/org/apache/spark/mllib/linalg/Matrix.html),我们提供两种实现：[SparseＭatrix](http://spark.apache.org/docs/latest/api/java/org/apache/spark/mllib/linalg/SparseMatrix.html)和[DenseMatrix](http://spark.apache.org/docs/latest/api/java/org/apache/spark/mllib/linalg/DenseMatrix.html). 我们推荐使用Matrices中的工厂方法。记住，本地矩阵按列存储。

    import org.apache.spark.mllib.linalg.Matrix;
    import org.apache.spark.mllib.linalg.Matrices;

    Matrix dm = Matrices.dense(3, 2, new double[]{1.0, 3.0, 5.0, 2.0, 4.0, 6.0});
    Matrix sm = Matrices.sparse(3, 3, new int[]{0, 1, 3}, new int[]{0,2,1}, new double[]{9, 6, 8});

### 分布式矩阵

一个分布式矩阵是一个行列索引为long类型的双精度类型的值，在一个或多个RDD上分布存储。选择合适的格式存储大规模和分布式矩阵是很重要的。转换一个分布式矩阵到不同的合适可能需要全局的梳理(shuffle)，代价是昂贵的。目前已经实现了四种类型的分布式矩阵。

基础类型是 RowMatrix. 一个行矩阵是一个面向行分布的矩阵没有无意义的行索引， 例如一个集合向量集合。它有RDD的一行为基础，每一行是一个本地向量。我们假定行矩阵列的数量不是很巨大，这样单本地向量可以合理的与驱动程序交流沟通，因此能够在单个节点上存储，操作。一个有索引的行矩阵(IndexedRowMatrix)相似于带索引的行矩阵(RowMatrix), IndexedRowMatrix可以用来索引行和执行join操作。一个坐标矩阵(CoordinateMatrix) 是分布式矩阵存储为坐标列表([coordianate list](https://en.wikipedia.org/wiki/Sparse_matrix#Coordinate_list_.28COO.29))的格式,由RDD入口提供支持。一个块矩阵(BlockMatrix)是一个分布式矩阵由Matrix RDD(是一个(Int, Int, Matrix)的元祖)支持。

#### RowMatrix

    import org.apache.spark.api.java.JavaRDD;
    import org.apache.spark.mllib.linalg.Vector;
    import org.apache.spark.mllib.linalg.distributed.RowMatrix;

    JavaRDD<Vector> rows = ...;
    RowMatrix mat = new RowMatrix(rows.rdd());

    long m = mat.numRows()
    long n = mat.numCols()

#### IndexedRowMatrix

一个 [IndexedRowMatrix](http://spark.apache.org/docs/latest/api/java/org/apache/spark/mllib/linalg/distributed/IndexedRowMatrix.html)可以从一个JavaRDD<IndexedRow> 实例创建，IndexedRow 是一个(long, Vector)的封装。一个IndexRowMatrix 可以去掉索引转换为RowMatrix.

    import org.apache.spark.api.java.JavaRDD;
    import org.apache.spark.mllib.linalg.distributed.IndexedRow;
    import org.apache.spark.mllib.linalg.distributed.IndexedRowMatrix;
    import org.apache.spark.mllib.linalg.distributed.RowMatrix;

    JavaRDD<IndexedRow> rows = ...;
    IndexedRowMatrix mat = new IndexedRowMatrix(rows.rdd());
    long m = mat.numRows();
    long n = mat.numCols();

#### CoordinateMatrix

CoordinateMatrix是有RDD入口提供支持的分布式矩阵。每个入口是(i: Long, j: Long, value: Double)类型的元组. CoordinateMatrix 只应该在矩阵维度很大而且矩阵非常稀疏的情况下才能使用。

CoordinateMatrix 可以从一个JavaRDD<MatrixEntry>实例创建，MatrixEntry是一个(long,long,double)的封装， CoordinateMatrix 可以转换为IndexedRowMatrix通过调用toIndexedRowMatrix.
    
    import org.apache.spark.api.java.JavaRDD;
    import org.apache.spark.mllib.linalg.distributed.CoordinateMatrix;
    import org.apache.spark.mllib.linalg.distributed.IndexedRowMatrix;
    import org.apache.spark.mllib.linalg.distributed.MatrixEntry;

    JavaRDD<MatrixEntry> entries = ...
    CoordinateMatrix mat = new CoordinateMatrix(entries.rdd());

    long m = mat.numRows();
    long n = mat.numCols();

    IndexedRowMatrix indexedRowMatrix = mat.toIndexedRowMatrix();

#### BlockMatrix

BlockMatrix 有RDD的MatrixBlocks提供支持，MatrixBlocks是一个((Int, Int), Matrix)类型的元祖,(Int,Int)是块索引，Matrix 是一个子矩阵。 BlockMatrix 支持add，multiply操作，validate()方法用于验证BlockMatrix是否合适的创建。

    JavaRDD<MatrixEntry> entries=...;
    CoordinateMatrix coorMat = new CoordinateMatrix(entries.rdd());
    BlockMatrix matA = coorMat.toBlockMatrix().cache();
    mat.validate();
    BlocakMatrix ata = matA.transpose().multiply(matA);

## 基于RDD Api的基础的统计(Basic Statistics -RDD-based API)

我们通过在Statistics中的colStats函数获得RDD[Vector]的列总结统计。

    import org.apache.spark.api.java.JavaRDD;
    import org.apache.spark.mllib.linalg.Vector;
    import org.apache.spark.mllib.linalg.Vectors;

    import org.apache.spark.mllib.stat.MultivariateStatisticalSummary;
    import org.apache.spark.mllib.stat.Statistics;

    JavaRDD<Vector> mat = jsc.parallelize(
        Arrays.asList(
            Vectors.dense(1.0, 10.0, 100.0);
            Vectors.dense(2.0, 20.0, 200.0);
            Vectors.dense(3.0, 30.0, 300.0);
        )
    );

    MultivariateStatisticalSummary summary = Statistics.colStats(mat.rdd());
    System.out.println(summary.mean());    
    System.out.println(summary.variance());            //列宽变量
    System.out.println(summary.numNonzeros(());        //每一列的非0数

### 相关性

统计学中计算两列数据的相关性是很常见的。在spark.mllib中我们提供了在很多列之间计算列祖相关的灵活性。目前支持的相关性方法是 Pearson 和 Spearman 相关。

    [Statistics](http://spark.apache.org/docs/latest/api/java/org/apache/spark/mllib/stat/Statistics.html)提供了方法计算两列之间的相关性。取决于输入类型，两个JavaDoubleRDDs 或者JavaRDD<Vector>,输出相应的为Double或者相关矩阵。

    import java.util.Arrays;

    import org.apache.spark.api.java.JavaDoubleRDD;
    import org.apache.spark.api.java.JavaRDD;
    import org.apache.spark.mllib.linalg.Matrix;
    import org.apache.spark.mllib.linalg.Vector;
    import org.apache.spark.mllib.linalg.Vectors;
    import org.apache.spark.mllib.stat.Statistics;

    //与seriesX必须拥有相同的分区
    JavaDoubleRDD seriesX = jsc.parallelizeDoubles(
        Arrays.asList(11.0, 22.0, 33.0, 33.0, 555.0)
    );

    //使用Pearson计算相关性
    //如果没有明确方法，Pearson是默认方法
    Double correlation = Statics.corr(seriesX.srdd(), seriesY.srdd(), "pearson");
    System.out.println("Correalation is: " + corrlation);

    JavaRDD<Vector> data = jsc.parallelize(
        Arrays.asList(
            Vectors.dense(1.0, 10.0, 100.0),
            Vectors.dense(2.0, 20.0, 200.0),
            Vectors.dense(5.0, 33.0, 366.0)
        )
    );

    //计算相关性矩阵使用Peason's 方法
    //使用 “spearman" 作为Spearman方法

### 分层样本(Stratified sampleing)

不想其他统计工具，

## [基于RDD的聚类和回归(Classfication and Regression - RDD-based)](http://spark.apache.org/docs/latest/mllib-classification-regression.html)

spark.mllib包支持各种方法，二分聚类，多类聚类，回归分析。下表概括了每种类型的支持算法。

| 问题类型(Problem Type) | 支持的方法(Supported Method) |
| :------------| :----------------|
| 二分聚类(Binary Classification) | 线性 SVMS(LINEAR SVMs), 逻辑回归(logistic regression), 决策树(decision trees), 随机森林(random forests), 梯度增加树(gradient-bosted trees), 朴素贝叶斯(naive Bayes) |
| 多类聚类 | 逻辑回归(logistic regression), 决策树(decision trees), 随机森林(random forests),朴素贝叶斯(naive Bayes) |
| 回归 | 线性最小平方(linear lease squares), 套索(Lasso), 山脊回归(ridge regression), 决策树(decision trees), 随机森林(random forests), 梯度增加树(gradient-bosted trees), 等压回归(isotonic regression) |

### [线性方法](http://spark.apache.org/docs/latest/mllib-linear-methods.html)

#### Mathematical formulation

#### Loss functions

#### Regularizers

#### Optimization

#### 分类(Classifacation)

最常用的分类是二分聚类，分为有名的正值和负值。如果超过两类，叫多类分类。spark.mllib支持两种线性分类方法

