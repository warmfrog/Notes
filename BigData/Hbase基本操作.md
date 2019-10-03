


* 启动 hbase

    start-all.sh     启动 hadoop
    start-hbase.sh   启动 hbase

* 进入 Hbase shell 控制台

    hbase shell

* 创建表

    create 'test', cf1'

test: 表名; cf1: 列族1;

* 查看数据库中的表

    list

* 查看表属性

    describe 'test

* 添加新列族

    alter 'test', 'cf2'

在生产环境中最好 disable 表。

* 插入数据

    put 'test', 'row1', 'cf:name', 'jack'

* 查看表数据

    scan 'test'

* 使表支持多个版本

    alter 'test',{NAME=>'CF',VERSIONS=>5}

* 按条件查询

    scan 'test', {STARTROW=>'row3'}
    scan 'test', {ENDROW=>'row4'}

* 获取单元格数据

    get 'test','row7','cf:name'

获取多个版本

    get 'test','row7',{COLUMN=>'cd:name', VERSIONS=>5}

    scan 'test',{VERSIONS=>5}

* 删除数据

    delete 'test', 'row112','cf:name'

根据版本删除数据

    delete 't1','r1','c1',ts

该命令删除改版本及以前的数据。ts 版本号。

删除整行

    delete all 'test','row3'

* disable 停用表

    disable 'test'

* drop 删除表

    drop ‘test'

* status 查看集群状态

    status
    status 'simple'
    status 'summary'
    status 'detailed'

* version 产看HBase版本

    version

* whoami 查看当前用户

* table_help 输出表操作标注信息

## 表操作

* list
* alter

* enable 启动表

    enable 'test'

* exists 判断表存在

    exists 'test'

## 数据操作

* scan 遍历表

    scan 'test'

* count 计算表行数

    count 'table1'

* truncate 清空表数据，保留表属性

    truncate 'table1'

## 工具方法

* close_region 下线指定 Region

    locate_region 'table', 'row1'
    close_region 'table1, 150325003423.8324sdfjkr29df.'





