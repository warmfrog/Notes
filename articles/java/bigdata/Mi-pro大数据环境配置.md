


这是我在自己笔记本中学习大数据的配置，使用 Virtualbox6.0 虚拟机软件. 对每台虚拟机设置了网卡1 NAT网卡和网卡2 桥接网卡，桥接网卡设置界面名称 Realtec USB FE Family Controller, 并在每台虚拟机中安装了 openssh-server. NAT网卡是的虚拟机可以通过宿主机联网，桥接网卡使虚拟机拥有和主机不同的独立局域网ip，并和宿主机在同一个网段。

目前安装了5台 ubuntu 18.04 linux主机，每台设置内存1GB，硬盘20GB，显存128MB，开启3D加速:

* node1@192.168.101.237
* node2@192.168.101.239
* node3@192.168.101.240
* node4@192.168.101.241
* node5@192.168.101.243

添加用户

    sudo su root
    useradd hadoop
    passwd "159491"

将hadoop 添加到sudoers, NOPASSWD 表示切换sudo时无须密码

    chmod u+x /etc/sudoers
    vim /etc/sudoers
    hadoop ALL=NOPASSWD:ALL

测试hadoop 用户是否有sudo 权限

    sudo whoami

创建用户目录

    sudo mkdir /home/hadoop
    sudo chown hadoop /home/hadoop

生成rsa密匙

    ssh-keygen -t rsa

因为总共有4台虚拟机，每台虚拟机都要用ssh-keygen -t rsa 生成密匙，然后将生成的所有共识 id_rsa追加到同一个authorized_keys 文件中，并复制到每台虚拟机的 hadoop/.ssh/ 目录中。并且修改权限为 chmod 700 ~/.ssh/authorized_keys.

配置完成后，就可以在任意一台虚拟机通过 ssh hostname , 例如 ssh node4 访问对应node4主机，而不需要密码。

## 环境配置

* 关闭屏幕锁

    Settings->Privacy->Screen Lock->Off

* 软件包目录 /home/node1/Documents
* 环境安装目录 /env

### 软件安装目录 Virtualbox

* java8 /env/jdk1.8
* hadoop-2.9.2 /env/hadoop-2.9.2

### 设置环境变量 Virtualbox

#### 环境变量

    vim ~/.bashrc

* 添加 Java 环境变量

    export JAVA_HOME=/env/jdk1.8
    export JRE_HOME=${JAVA_HOME}/jre
    export CLASSPATH=:${JAVA_HOME}/lib:${JRE_HOME}/lib
    export PATH=${JAVA_HOME}/bin:$PATH

* hadoop 环境变量 .bashrc

    export HADOOP_HOME=/env/hadoop-2.9.2
    export HADOOP_PREFIX=$HADOOP_HOME
    export HADOOP_MAPRED_HOME=$HADOOP_HOME
    export HADOOP_COMMON_HOME=$HADOOP_HOME
    export HADOOP_HDFS_HOME=$HADOOP_HOME
    export YARN_HOME=$HADOOP_HOME
    export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
    export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin
    export HADOOP_INSTALL=$HADOOP_HOME

* 修改hadoop 配置文件， $HADOOP_HOME/etc/hadoop/hadoop-env.sh

添加

    export HADOOP_NAMENODE_OPTS=" -Xms1024m -Xmx1024m -XX:+UseParallelGC"
    export HADOOP_DATANODE_OPTS=" -Xms1024m -Xmx1024m"
    export HADOOP_LOG_DIR=/data/logs/hadoop

由于本机只有8G内存，并且开了5个虚拟机，所以上述相应的调小了些。该为如下

    export HADOOP_NAMENODE_OPTS=" -Xms256m -Xmx512m -XX:+UseParallelGC"
    export HADOOP_DATANODE_OPTS=" -Xms256m -Xmx512m"
    export HADOOP_LOG_DIR=/data/logs/hadoop

修改 JAVA_HOME

    export JAVA_HOME=/env/jdk1.8




* 使环境变量生效

    source ~/.bashrc

注意每台主机都有该相同的.bashrc 配置文件

### 复制虚拟机

上述配置完成后，关闭虚拟机，然后复制3份，重命名为node2,node3,node4

修改每台虚拟机/etc/hosts

    192.168.101.237 node1
    192.168.101.239  node2
    192.168.101.240 node3
    192.168.101.241 node4
    192.168.101.243 node5

重启网卡，使立刻生效

sudo /etc/init.d/networking restart

修改每台虚拟机/etc/hostname,node1只写node1,其他也一样

    node1
    node2
    node3
    node4
    node5

然后每台主机执行

    hostname 主机名

例如虚拟机node1

    hostname node1

### hadoop 系统配置

* 创建目录,在每台虚拟机上创建，并将拥有者付给hadoop用户

    sudo mkdir -p /data/logs/hadoop
    sudo mkdir -p /data/hadoop/hdfs/nn
    sudo mkdir /data/hadoop/hdfs/dn
    chown hadoop /data
    chown hadoop /data/*

* core-site.xml

    <configuration>
        <property>
                <name>fs.defaultFS</name>
                <!-- 此处每台虚拟机的地址做相应调整，如node1,node2-->
                <value>hdfs://node1:8020</value>
        </property>
    </configuration>

* hdfs-site.xml

     <property>
                <name>dfs.replication</name>
                <value>1</value>
        </property>
        <property>
                <name>dfs.namenode.name.dir</name>
                <value>file:///data/hadoop/hdfs/nn</value>
        </property>
        <property>
                <name>dfs.datanode.data.dir</name>
                <value>file:///data/hadoop/hdfs/dn</value>
        </property>

* 格式化 namenode

对每个虚拟机进行此操作

    hdfs namenode -format

### 虚拟机配置结果

* node1 OK
* node2 OK
* node3 OK
* node4 OK

### 友情提示

安装 Hadoop 和 HBase 这种分布式系统最好用一些批量执行命令的小工具，比如pssh或dsh。

### Virtualbox端口转发

在Virtualbox 设置网卡为NAT 模式，点击高级，配置NAT 转发规则，配置主机IP 和端口，虚拟机IP 和端口，然后就可以通过 主机IP 和端口访问在主机中访问虚拟机中提供的服务了。

### 集群配置

修改所有节点core-site.xml fs.defaultFS = hdfs://node1:8020, 并在所有节点上进行如下操作，进行数据删除

    rm -rf /data/hadoop/hdfs/nn/current
    rm -rf /data/hadoop/hdfs/dn/current

### 启动集群

* 在node1 上启动namenode
    hadoop-daemon.sh --script hdfs start namenode

* 停止namenode

    hadoop-daemon.sh --script hdfs stop namenode

* 在node2-node4 上启动 datanode

    hadoop-daemons.sh --script hdfs start datanode

关闭 datanode

    hadoop-daemons.sh --script hdfs stop datanode