# [Posgresql][1] 用法记录

ubuntu 系统仓库里的 postgresql 比官方更新的慢，18.04 LTS 中是 postgresql 10。

## 安装配置

### 安装

```bash

sudo apt install postgresql

```

安装完成后，默认创建一个用户 postgres，没有密码，可以用来登录 postgresql 数据库。

### 以 postgres 用户身份登录到 psql 控制台

```bash

sudo -u postgres psql

```

### 修改 postgres 密码

```bash

alter user postgres with password '159491';

```

### 配置数据库以允许远程连接访问

安装完成后，默认只能本地才能连接数据库，其他机子访问不了，需要进行配置。

#### 1. 修改监听地址

```bash

sudo gedit /etc/postgresql/9.5/main/postgresql.conf
```

将 #listen_addresses = 'localhost' 的注释去掉并改为 listen_addresses = '*'。

#### 修改可访问用户的IP段

```bash

sudo gedit /etc/postgresql/9.5/main/pg_hba.conf 
```

在文件末尾添加： host all all 0.0.0.0 0.0.0.0 md5 ，表示运行任何IP连接。

#### 重启数据库

```bash

sudo /etc/init.d/postgresql restart
```

### 添加新用户

运行系统用户"postgres"的psql命令，进入客户端：

`sudo -u postgres psql`

创建用户"xiaozhang"并设置密码：

`postgres=# create user xiaozhang with password '123456';`

创建数据库exampledb，所有者为xiaozhang：

`postgres=# create database exampledb owner xiaozhang;`

将exampledb数据库的所有权限赋予xiaozhang，否则xiaozhang只能登录psql，没有任何数据库操作权限：

`grant all privileges on database exampledb to xiaozhang;`











[1]: https//:postgresql.org
[2]: https//:www.baidu.com
