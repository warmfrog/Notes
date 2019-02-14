


* 安装Spark-2.4.0

    tar xf spark-2.4.0.tar.gz -C /env

将 spark-2.4.0/yarn 目录下的 spark-2.4.0-yarn-shuffle.jar 拷贝到/env/hadoop-2.9.2/share/hadoop/yarn/lib 目录下

递归更该spark目录的拥有者

    chown -R warmfrog /env/spark-2.4.0 

* 配置spark 环境变量

    cd /env/spark-2.4.0/conf
    cp spark-env.sh.template spark-env.sh
    vim spark-env.sh

添加如下环境变量

    export JAVA_HOME=/env/jdk1.8
    export HADOOP_HOME=/env/hadoop-2.9.2
    export HADOOP_CONF_DIR=/env/hadoop-2.9.2/etc/hadoop
    export YARN_CONF_DIR=/env/hadoop-2.9.2/etc/hadoop
    export SPARK_HOME=/env/spark-2.4.0
    export SPARK_LIBRARY_PATH=.:$JAVA_HOME/lib:$JAVA_HOME/jre/lib:$HADOOP_HOME/lib/native
    export SPARK_MASTER_IP=127.0.0.1
    export SPARK_MASTER_HOST=hdfs
    export SPARK_LOCAL_DIRS=/env/spark-2.4.0
    export SPARK_YARN_USER_ENV=="CLASSPATH=/env/hadoop-2.9.2/etc/hadoop"


* 修改hadoop 配置

    vim /env/hadoop-2.9.2/etc/hadoop/yarn-site.xml

添加如下配置

    <configuration>
        <property>
                <name>yarn.nodemanager.aux-services</name>
                <value>mapreduce_shuffle,spark_shuffle</value>
        </property>
        <property>
                <name>yarn.nodemanager.aux-services.mapreduce.shuffle.class</name>
                <value>org.apache.hadoop.mapred.ShuffleHandler</value>
        </property>
        <property>
                <name>yarn.nodemanager.aux-services.spark_shuffle.class</name>
                <value>org.apache.spark.network.yarn.YarnShuffleService</value>
        </property>
        <property>
                <name>yarn.nodemanager.log-dir</name>
                <value>file:/env/hadoop-2.9.2/logs</value>
        </property>
        <property>
                <name>yarn.resourcemanager.hostname</name>
                <value>127.0.0.1</value>
        </property>
        <property>
                <name>yarn.resourcemanager.address</name>
                <value>127.0.0.1:8032</value>
        </property>
        <property>
                <name>yarn.resourcemanager.webapp.address</name>
                <value>127.0.0.1:8088</value>
        </property>
        <property>
                <name>yarn.nodemanager.pmem-check-enabled</name>
                <value>false</value>
        </property>
        <property>
                <name>yarn.nodemanager.vmem-check-enabled</name>
                <value>false</value>
        </property>

    </configuration>

* 启动 spark

    /env/spark-2.4.0/sbin/start-all.sh

* 网页查看hadoop

    http://127.0.0.1:8088

* 网页查看spark

    http://127.0.0.1:8080
                                      