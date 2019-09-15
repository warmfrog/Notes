


Hadoop 有三种运行模式：本地独立模式，伪分布模式，完全分布式模式。如果不进行任何配置，默认为本地独立模式。

VMware15.0.2安装的ubuntu虚拟机下配置.

## 环境配置

### 软件安装目录

* java8 /home/bigdata/env/jdk1.8
* eclipse /home/bigdata/env/eclipse

* 安装 ssh-server
    sudo apt install openssh-server
* 生成密匙
    ssh-keygen -t rsa
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
    chmod 600 ~/.ssh/authorized_keys

### Java 环境变量

    vim ~/.bashrc

    export JAVA_HOME=/home/bigdata/env/jdk1.8
    export JRE_HOME=${JAVA_HOME}/jre
    export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
    export PATH=${JAVA_HOME}/bin:$PATH

* 使环境变量生效

    source ~/.bashrc

### Hadoop 配置

* hadoop 环境变量

    vim /etc/profile

    export HADOOP_HOME=/home/bigdata/env/hadoop-2.9.2
    export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

* hadoop-env.sh

    export JAVA_HOME=/home/bigdata/env/jdk1.8

* mapred-site.xml

    cp mapred-site.xml.template mapred-site.xml

添加以下属性到configuration标签里

     <property>
                <name>mapreduce.framework.name</name>
                <value>yarn</value>
                <final>true</final>
        </property>
        <property>
                <name>mapreduce.jobhistory.address</name>
                <value>127.0.0.1:10020</value>
        </property>
        <property>
                <name>mapreduce.jobhistory.webapp.address</name>
                <value>127.0.0.1:19888</value>
        </property>

* core-site.xml

        <property>
                <name>fs.defaultFS</name>
                <value>hdfs://127.0.0.1:8020</value>
        </property>
        <property>
                <name>hadoop.tmp.dir</name>
                <value>/home/bigdata/HDFSData</value>
        </property>
        <property>
                <name>ha.zookeeper.quorum</name>
                <value>127.0.0.1:2181</value>
        </property>

* hdfs-site.xml

        <property>
                <name>dfs.namenode.name.dir</name>
                <value>/home/bigdata/HDFSData/dfs/name</value>
        </property>
        <property>
                <name>dfs.datanode.data.dir</name>
                <value>/home/bigdata/HDFSData/dfs/data</value>
        </property>
        <property>
                <name>dfs.replication</name>
                <value>1</value>
        </property>
        <property>
                <name>dfs.namenode.handler.count</name>
                <value>100</value>
        </property>
        <property>
                <name>dfs.webhdfs.enabled</name>
                <value>true</value>
        </property>

#### 初始化 hadoop

* 初始化 hadoop
    hadoop namenode -format

* 启动 hadoop
    start-all.sh

* 查看java进程
    jps

* 关闭 hadoop

    stop-all.sh

### hbase 配置

* 安装 hbase-1.2.9

    tar xf habse-1.2.9.tar.gz -C /env

* 配置环境变量

    sudo vim /etc/profile
    export HBASE_HOME=/env/hbase-1.2.9
    export PATH=$PATH:$HBASE_HOME/bin

*hbase-env.sh

    exporg JAVA_HOME=/env/jdk1.8

* hbase-site.xml

        <property>
                <name>hbase.rootdir</name>
                <value>hdfs://127.0.0.1:8020/hbase</value>
        </property>
        <property>
                <name>hbase.cluster.distributed</name>
                <value>true</value>
        </property>
        <property>
                <name>hbase.master</name>
                <value>127.0.0.1:60000</value>
        </property>
        <property>
                <name>hbase.zookeeper.quorum</name>
                <value>127.0.0.1</value>
        </property>
        <property>
                <name>zookeeper.znode.parent</name>
                <value>/hbase</value>
        </property>

* 启动hbase

        start-hbase.sh

* 关闭hbase

        stop-hbase.sh